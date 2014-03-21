#!/bin/bash


JG=$HOME/JGroupsArticles
LIB=$JG/lib

CP=$JG/classes
for i in $LIB/*.jar
do
    CP=$CP:$i
done


# -XX:MaxGCPauseMillis=<nnn>

#This is interpreted as a hint to the garbage collector that pause times of <nnn>
#milliseconds or less are desired. The garbage collector will adjust the Java
#heap size and other garbage collection related parameters in an attempt to keep
#garbage collection pauses shorter than <nnn> milliseconds. By default there is
#no maximum pause time goal. These adjustments may cause the garbage collector to
#occur more frequently, reducing the overall throughput of the application. In
#some cases the desired pause time goal cannot be met.



# -XX:GCTimeRatio=<nnn>

# The ratio of garbage collection time to application time is
# 1 / (1 + <nnn>)

# For example -XX:GCTimeRatio=19 sets a goal of 1/20th or 5% of the total time for
# garbage collection.

# The time spent in garbage collection is the total time for both the young
# generation and old generation collections combined. If the throughput goal is
# not being met, the sizes of the generations are increased in an effort to
# increase the time the application can run between collections.



FLAGS="-server -Xmx600M -Xms400M -XX:+AggressiveHeap -XX:ThreadStackSize=64 -XX:CompileThreshold=100 -XX:SurvivorRatio=8 -XX:TargetSurvivorRatio=90 -XX:MaxTenuringThreshold=31"
#FLAGS="-server -Xmx300m -Xms300m -Xmn200m -Xss128k -XX:ParallelGCThreads=20 -XX:+UseConcMarkSweepGC -XX:+UseParNewGC -XX:SurvivorRatio=8 -XX:TargetSurvivorRatio=90 -XX:MaxTenuringThreshold=31"


#FLAGS="-server -Xmn200M -Xmx400M -Xms400M -XX:NewRatio=5 -XX:+AggressiveHeap -XX:ThreadStackSize=32 -XX:CompileThreshold=1000"


#FLAGS="-Xmx250M -Xms250M -server -XX:CompileThreshold=100"

#LOG="-Dorg.apache.commons.logging.Log=org.apache.commons.logging.impl.Jdk14Logger -Djava.util.logging.config.file=c:\logging.properties"
LOG="-Dlog4j.configuration=file:$HOME/log4j.properties"

FLAGS="$FLAGS -Djava.net.preferIPv4Stack=true -Djgroups.timer.num_threads=3"
#PROF="-Xrunhprof:cpu=samples,monitor=y,depth=8,thread=y"

#PROF_LOC=/home/bela/jboss-profiler

#PROF="-javaagent:$PROF_LOC/jboss-profiler.jar -Djboss-profiler.properties=$PROF_LOC/jboss-profiler.properties"

#CP=$CP:$PROF_LOC/jboss-profiler.jar

#XFLAGS="-XX:+EliminateLocks -XX:+UseBiasedLocking"
#XFLAGS="-XX:+DoEscapeAnalysis -XX:+EliminateLocks -XX:+UseBiasedLocking -XX:+AggressiveOpts"

## Excellent option for JDK 6 !
XFLAGS="-XX:+UseBiasedLocking"


#PROF="-Xrunhprof:cpu=samples,monitor=n,thread=n"

#BOOT="-Xbootclasspath/p:$CP"

#EXPERIMENTAL="-Xrunhprof"

java $BOOT $EXPERIMENTAL -Ddisable_canonicalization=true -classpath $CP -Djgroups.bind_addr=$IP_ADDR -Djboss.tcpping.initial_hosts=192.168.1.5[7800] $LOG $FLAGS $XFLAGS $PROF -Dcom.sun.management.jmxremote -Dresolve.dns=false $*

