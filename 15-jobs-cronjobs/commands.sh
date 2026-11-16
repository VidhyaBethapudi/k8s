kubectl apply -f job.yaml
kubectl get jobs -n dev
kubectl logs job/db-migration -n dev

kubectl apply -f cronjob.yaml
kubectl get cronjob -n dev
kubectl get jobs -n dev --watch
# Manually trigger a CronJob run
kubectl create job manual-backup-1 --from=cronjob/nightly-backup -n dev
