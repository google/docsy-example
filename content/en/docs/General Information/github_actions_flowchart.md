---
title: "Github Actions Flowchart"
linkTitle: "Github Actions Flowchart"
weight: 5
description: >
  Flowchart of Github actions active on the COAsT and COAsT-Site repositories.
---

# GitHub actions diagram

This is a collection of flowcharts for all the GitHub actions used across the COAsT and COAsT-site repos
## COAsT
### building Packages
{{< mermaid align="left">}}
graph LR;    
    subgraph publish_package - runs on push to master
    A1[Setup python]-- 3.8 -->B1;    
    B1[Install dependencies]-->C1;
    C1[Setup Enviroment]-->D1;
    D1[Build package]-->E1;
    E1[Test Package Install]-->F1
    F1[Publish to pypi]-->G1
    G1[Generate Conda Metadata]-->H1
    H1[Publish to Anaconda]
    end;
    
    subgraph build_package - runs on push to non-master 
    A[Setup python]-- 3.8 and 3.9 -->B;    
    B[Install dependencies]-->C;
    C[Setup Enviroment]-->D;
    D[Build package]-->E;
    E[Test Package Install]-->F
    F[Generate Conda Metadata] 
    end;
{{< /mermaid >}}

### Verification, Formatting ans Pylint
{{< mermaid align="left">}}
graph LR

    subgraph formatting - runs on pull requests
    A[Setup python]-- 3.9 -->B;    
    B[Install black]-->C;
    C[Check formatting]--> D;
    D[Apply formatting]
    end;

    subgraph pylint - runs on pull requests
    A1[Setup python]-- 3.9 -->B1;    
    B1[Install pylint]-->C1;
    C1[Check Score]-- if test pass --> D1;
    D1[Update Score]
    end;
    
    subgraph verifiy_package - runs for every push
    A2[Setup python]-- 3.8 and 3.9 -->B2;    
    B2[Install dependencies]-->C2;
    C2[Lint]-->D2;
    D2[Test]
    end;
    click B1 "https://www.github.com" "tooltip"
{{< /mermaid >}}

### interactions with other repos
{{< mermaid align="left">}}
flowchart LR
    subgraph b1[push_notebooks - runs on push to develop]
        direction LR
        subgraph b2[COAsT site - markdown ]
            direction TB
            a[checkout docsy site] -->b
            b[checkout coast] -->c
            c[create environment] -->d
            d[execute notebooks] -->e
            e[covert notebooks to MD] -->f
            f[move images to static dir] -->g
            g[commit changes]            
         end
    t[Repository Dispatch] -- event pushed --> b2    
    end
    click a "https://github.com/British-Oceanographic-Data-Centre/COAsT-site" "Docsy site for COAsT repo"
{{< /mermaid >}}

{{< mermaid align="left">}}
flowchart LR
    subgraph b3[push_docstrings - runs on push to master]
        direction LR
        subgraph b4[COAsT site - docstrings ]
            direction TB
            a1[checkout docsy site] -->b1
            b1[checkout coast] -->c1
            c1[add python] -->d1
            d1[covert docstrings] -->e1
            e1[commit changes]            
        end
    r[Repository Dispatch] -- event pushed --> b4       
    end
    click a1 "https://github.com/British-Oceanographic-Data-Centre/COAsT-site" "Docsy site for COAsT repo"
{{< /mermaid >}}

### Generate unit test contents file
{{< mermaid align="left">}}
graph LR
    subgraph generate-test-contents - runs on pull_request
    A[checkout COAsT]-->B;    
    B[install package]-->C;
    C[make example files dir]--> D;
    D[run generate_unit_test_contents.py]-->E
    E[commit changes]
    end;
{{< /mermaid >}}

## COAsT-site
These are the actions used on the COAsT-site repo. 

### Convert to markdown
See [Interactions with other repos](#interactions-with-other-repos) for the related markdown and docstring workflows

### Build site
{{< mermaid align="left">}}
graph LR
    subgraph hugo - runs on push to master
    A[checkout site]-->B;    
    B[Setup Hugo] -- v0.70.0 -->C;
    C[Setup Nodejs]-- v12 --> D;
    D[Build]-->E
    E[Deploy]
    end;
{{< /mermaid >}}
