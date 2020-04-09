docker build -t toks122/multi-client:latest -t toks122/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t toks122/multi-server:latest -t toks122/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t toks122/multi-worker:latest -t toks122/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push toks122/multi-client:latest
docker push toks122/multi-server:latest
docker push toks122/multi-worker:latest

docker push toks122/multi-client:$SHA
docker push toks122/multi-server:$SHA
docker push toks122/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=toks122/multi-server:$SHA
kubectl set image deployments/client-deployment client=toks122/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=toks122/multi-worker:$SHA
