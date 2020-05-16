---
title: "Function Pod"
weight: 5
description: >
  Place to load and execute the user function
---

# Brief Intro

Function Pod is for serving HTTP requests from the clients. It contains two 
containers: Fetcher and Environment Container. 

# Diagram

{{< img "../assets/function-pod.png" "Fig.1 Function Pod" "50em" "1" >}}

1. Fetcher gets the function information from the CRD.
2. Pull the deployment archive from the StorageSvc.
3. Save the archive to the shared volume.
4. Call the specialized endpoint on the environment container to start function specialization.
5. Environment Container loads the user function from the volume.
6. Start serving the requests from Router.

# Environment Container
Environment Container runs user-defined functions and is language-specific. 
Each environment container must contain an HTTP server and a loader for functions.

# Fetcher

Fetcher is responsible to pull deployment archive from the StorageSvc and verify the checksum
of file to ensure the integrity of file.
