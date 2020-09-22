uri=$1

echo "========== Iniciando espera de respuesta para "uri ..."

while true
do
  STATUS=$(curl -s -o /dev/null -w '%{http_code}' $uri)
  if [ $STATUS -eq 200 ]; then
    echo "Servicio OK"
    break
  else
    echo "Got $STATUS :( Not done yet..."
  fi
  sleep 3
done

echo "==========  Fin de la espera"