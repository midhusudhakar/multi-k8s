docker build -t midhunsudhakar/multi-client:latest -t midhunsudhakar/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t midhunsudhakar/multi-server:latest -t midhunsudhakar/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t midhunsudhakar/multi-worker:latest -t midhunsudhakar/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push midhunsudhakar/multi-client:latest
docker push midhunsudhakar/multi-server:latest
docker push midhunsudhakar/multi-worker:latest

docker push midhunsudhakar/multi-client:$SHA
docker push midhunsudhakar/multi-server:$SHA
docker push midhunsudhakar/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployments server=midhunsudhakar/multi-server:$SHA
kubectl set image deployments/client-deployment client=midhunsudhakar/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=midhunsudhakar/multi-worker:$SHA


