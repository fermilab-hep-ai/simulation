import cmd
from glob import glob
import os

high_performance = False
job_files = glob("job_csvs/batch22/*.csv")

for job_file in job_files:
    print(f"Processing {job_file}")
    job_name = os.path.splitext(os.path.basename(job_file))[0]
    if high_performance:
        cmd = f"python3 submit_to_slurm.py -o /p/scratch/laionize/ploner1/full_production_1percent/{job_name} -csv {job_file} --simdir /p/home/jusers/ploner1/juwels/ploner1_juwels/simulation -l {job_name} -hp"
    else:
        cmd = f"python3 submit_to_slurm.py -o /p/scratch/laionize/ploner1/full_production_1percent/{job_name} -csv {job_file} --simdir /p/home/jusers/ploner1/juwels/ploner1_juwels/simulation -l {job_name}"
    result = os.system(cmd)
    if result != 0:
        print(f"Error processing {job_file}")
    else:
        print(f"Successfully submitted {job_name}")