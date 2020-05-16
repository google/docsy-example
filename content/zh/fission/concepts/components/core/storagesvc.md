---
title: "StorageSvc"
weight: 8
description: >
  Home for source and deployment archives
---

# Brief Intro

The storage service is the home for all archives of packages with sizes larger than 256KB.
The Builder pulls the source archive from the storage service and uploads deploy archive to it.
The fetcher inside the function pod also pulls the deploy archive for function specialization.

# Diagram

{{< img "../assets/storagesvc.png" "Fig.1 StorageSvc" "50em" "1" >}}

1. Client (CLI or HTTP requests) connects to the StorageSvc proxy endpoint on Controller.
2. Controller proxies requests to StorageSvc.
3. StorageSvc stores uploaded archives to the Kubernetes persistent volume.
4. (A) To build source archive into deployment archive, the Fetcher in the 
builder pod downloads source archive and save to shared volume. Once the 
build process finished, the Fetcher uploads the deployment archive to StorageSvc.
5. (B) The Fetcher inside function pod fetches deployment archive created in (A) 
for environment container to load in.
