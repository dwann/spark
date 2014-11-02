# This is a powershell script that assembles compiled Spark for distribution

$FWDIR=split-path -parent $MyInvocation.MyCommand.Definition
$DISTDIR="$FWDIR/dist"

# Make directories
Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "$DISTDIR"
New-Item -Path "$DISTDIR/lib" -ItemType directory
echo "Spark $VERSION built for Hadoop $SPARK_HADOOP_VERSION" > "$DISTDIR/RELEASE"

# Copy jars
cp $FWDIR/assembly/target/scala*/spark-assembly*.jar "$DISTDIR/lib/"
cp $FWDIR/examples/target/scala*/spark-examples*.jar "$DISTDIR/lib/"
cp $FWDIR/lib_managed/jars/datanucleus*.jar "$DISTDIR/lib/"

# Copy example sources (needed for python and SQL)
New-Item -Path "$DISTDIR/examples/src" -ItemType directory
cp -r "$FWDIR/examples/src/main" "$DISTDIR/examples/src/" 

# Copy license, ASF files and getting started files
cp "$FWDIR/LICENSE" "$DISTDIR"
cp "$FWDIR/NOTICE" "$DISTDIR"
cp "$FWDIR/CHANGES.txt" "$DISTDIR"
cp "$FWDIR/getting-started-with-spark-on-HDInsight.txt" "$DISTDIR"
cp "$FWDIR/wordcountinput.txt" "$DISTDIR"
cp "$FWDIR/pagerankinput.txt" "$DISTDIR"

# Copy other things
New-Item -Path "$DISTDIR/conf" -ItemType directory
cp $FWDIR/conf/*.template "$DISTDIR/conf"
cp "$FWDIR/conf/slaves" "$DISTDIR/conf"
cp "$FWDIR/README.md" "$DISTDIR"
cp -r "$FWDIR/bin" "$DISTDIR"
cp -r "$FWDIR/python" "$DISTDIR"
cp -r "$FWDIR/sbin" "$DISTDIR"
