workon scomp
export JOBNAME=$parsl.localprovider.1679960096.5835307
set -e
export CORES=$(getconf _NPROCESSORS_ONLN)
[[ "1" == "1" ]] && echo "Found cores : $CORES"
WORKERCOUNT=1
FAILONANY=0
PIDS=""

CMD() {
process_worker_pool.py  --max_workers=15 -a 128.111.85.28,included-crab,127.0.0.1 -p 0 -c 1.0 -m None --poll 10 --task_port=54309 --result_port=54554 --logdir=/home/kapsar/scalable-computing-examples/04-pleasing/runinfo/000/HighThroughputExecutor --block_id=1 --hb_period=30  --hb_threshold=120 --cpu-affinity none --available-accelerators  --start-method fork
}
for COUNT in $(seq 1 1 $WORKERCOUNT); do
    [[ "1" == "1" ]] && echo "Launching worker: $COUNT"
    CMD $COUNT &
    PIDS="$PIDS $!"
done

ALLFAILED=1
ANYFAILED=0
for PID in $PIDS ; do
    wait $PID
    if [ "$?" != "0" ]; then
        ANYFAILED=1
    else
        ALLFAILED=0
    fi
done

[[ "1" == "1" ]] && echo "All workers done"
if [ "$FAILONANY" == "1" ]; then
    exit $ANYFAILED
else
    exit $ALLFAILED
fi
