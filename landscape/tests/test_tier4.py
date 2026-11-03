"""
Tier 4 -- regression lock.

Tiers 1 to 3 only mean anything if the Julia reference they compare against is
the one that was actually reviewed.  This tier checks the committed fixtures
against MANIFEST.sha256, so a fixture that is regenerated in a different
environment (or edited) fails loudly instead of silently redefining what
"agreement" means.

If a mismatch is intentional -- a package upgrade, a change to the Julia source
-- regenerate the fixtures, rerun tiers 1 to 3, then refresh the manifest with

    cd landscape/julia_ref/fixtures
    sha256sum $(ls *.csv | grep -v '^tier3_events.csv$') > MANIFEST.sha256

and update the version table in landscape/julia_ref/ENVIRONMENT.md.
"""

import hashlib
import os
import unittest

FIXTURES = os.path.join(os.path.dirname(os.path.dirname(
    os.path.abspath(__file__))), "julia_ref", "fixtures")
MANIFEST = os.path.join(FIXTURES, "MANIFEST.sha256")

# regenerable, large, and not version controlled -- see .gitignore
UNTRACKED = {"tier3_events.csv"}


def sha256(path):
    h = hashlib.sha256()
    with open(path, "rb") as fh:
        for chunk in iter(lambda: fh.read(1 << 20), b""):
            h.update(chunk)
    return h.hexdigest()


class TestFixtureManifest(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        if not os.path.exists(MANIFEST):
            raise unittest.SkipTest("MANIFEST.sha256 missing")
        cls.want = {}
        with open(MANIFEST) as fh:
            for line in fh:
                line = line.strip()
                if not line:
                    continue
                digest, name = line.split(None, 1)
                cls.want[name.strip()] = digest

    def test_digests_match(self):
        bad = []
        for name, digest in sorted(self.want.items()):
            path = os.path.join(FIXTURES, name)
            if not os.path.exists(path):
                bad.append("{0}: missing".format(name))
            elif sha256(path) != digest:
                bad.append("{0}: content changed".format(name))
        self.assertEqual(bad, [], "fixture manifest mismatch:\n  " +
                         "\n  ".join(bad))
        print("\n  Tier 4: {0} fixtures match MANIFEST.sha256".format(
            len(self.want)))

    def test_manifest_covers_every_tracked_fixture(self):
        """A new fixture must be added to the manifest, not just dropped in."""
        present = {f for f in os.listdir(FIXTURES)
                   if f.endswith(".csv") and f not in UNTRACKED}
        missing = sorted(present - set(self.want))
        self.assertEqual(missing, [],
                         "fixtures not listed in MANIFEST.sha256: " +
                         ", ".join(missing))
        print("  Tier 4: manifest covers all {0} tracked .csv fixtures "
              "({1} deliberately excluded)".format(
                  len(present), len(UNTRACKED)))


if __name__ == "__main__":
    unittest.main(verbosity=2)
