NAME="jmetertest"
IMAGE="justb4/jmeter:latest"
ROOTPATH=$1
NOMBREREP=$4

echo "$ROOTPATH"

docker stop $NAME > /dev/null 2>&1
docker rm $NAME > /dev/null 2>&1
docker run --name $NAME -i -v $ROOTPATH:/test -w /test $IMAGE ${@:2}
echo "===================== Descarga de AzCopy"
wget -O azcopy.tar.gz https://aka.ms/downloadazcopy-v10-linux && tar -xf azcopy.tar.gz --strip-components=1
echo "===================== Descarga de Index"
./azcopy copy "https://resulttests.blob.core.windows.net/%24web/index.html?sv=2019-10-10&st=2020-09-20T18%3A38%3A00Z&se=2020-12-31T19%3A38%3A00Z&sr=c&sp=rwl&sig=PA9SPfvV5HeCaSEMR6NL4HCfw%2FWNU%2Fkq5DJVr1DfpS4%3D" "./index.html"
echo "===================== Carga de reporte a https://resulttests.blob.core.windows.net/%24web/rep/$NOMBREREP"
./azcopy copy "./report" "https://resulttests.blob.core.windows.net/%24web/rep/$NOMBREREP?sv=2019-10-10&st=2020-09-20T18%3A38%3A00Z&se=2020-12-31T19%3A38%3A00Z&sr=c&sp=rwl&sig=PA9SPfvV5HeCaSEMR6NL4HCfw%2FWNU%2Fkq5DJVr1DfpS4%3D" --recursive=true