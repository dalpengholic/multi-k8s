docker build -t dalpengholic/multi-client:latest -t dalpengholic/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dalpengholic/multi-server:latest -t dalpengholic/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dalpengholic/multi-worker:latest -t dalpengholic/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dalpengholic/multi-client:latest
docker push dalpengholic/multi-server:latest
docker push dalpengholic/multi-worker:latest

docker push dalpengholic/multi-client:$SHA
docker push dalpengholic/multi-server:$SHA
docker push dalpengholic/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dalpengholic/multi-server:$SHA
kubectl set image deployments/client-deployment client=dalpengholic/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dalpengholic/multi-worker:$SHA
