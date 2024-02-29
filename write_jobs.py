import csv
import argparse

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('-n','--nevent-per-job', type=int, default=10000)
    parser.add_argument('-i','--seed-increment', type=int, default=1)
    args = parser.parse_args()
    
    with open('jobs.csv', 'w') as csvfile:
        writer = csv.writer(csvfile, delimiter=',')
        writer.writerow(["Process", "Seed", "Nevents"])
        with open('num_proc.csv', 'r') as csvfile:
            reader = csv.reader(csvfile, delimiter=',')
            reader.__next__()
            for process, nevents, seed_offset in reader:
                for i in range(int(nevents) // args.nevent_per_job):
                    writer.writerow([
                        process, 
                        str(args.nevent_per_job), 
                        str(int(seed_offset) + i * args.seed_increment)
                    ])
                if int(nevents) % args.nevent_per_job > 0:
                    writer.writerow([
                        process, 
                        str(int(nevents) % args.nevent_per_job), 
                        str(int(seed_offset) + int(nevents) // args.nevent_per_job * args.seed_increment)
                    ])
if __name__ == "__main__":
    main()