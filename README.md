# Containerized Power BI Visual Development

Instead of installing pre-requisites and configuring a development environment for creating PowerBI custom visuals, just use this pre-made dev container to get straight to work.

Work transparently in a container using the Visual Studio Code Remote - Containers extension with live updating and debugging support.
 
## Developing a Power BI Visual
 
This section is to provide you with a step by step tutorial of developing a PowerBI visual using dev containers in VS Code.

![](/images/remote-containers.png)

## Prerequisites

* If you're not signed up for Power BI Pro, [sign up for a free trial](https://powerbi.microsoft.com/pricing/) before you begin.
* You need [Visual Studio Code](https://www.visualstudio.com/) installed.
* You need [Windows PowerShell](https://docs.microsoft.com/powershell/scripting/install/installing-windows-powershell?view=powershell-6) version 4 or later for windows users OR the [Terminal](https://macpaw.com/how-to/use-terminal-on-mac) for OSX users.

In addition, you will require the appropriate Docker components for your development platform.

* Windows: [Docker Desktop](https://www.docker.com/products/docker-desktop) 2.0+ on Windows 10 Pro/Enterprise. (Docker Toolbox is not supported. Windows container images are not supported.)
* macOS: [Docker Desktop](https://www.docker.com/products/docker-desktop) 2.0+.
* Linux: [Docker CE/EE](https://docs.docker.com/install/#supported-platforms) 18.06+ and [Docker Compose](https://docs.docker.com/compose/install) 1.21+. (The Ubuntu snap package is not supported.)

## Setting up the development environment

Refer to [Setting up the developer environment](https://docs.microsoft.com/en-au/power-bi/developer/visuals/custom-visual-develop-tutorial#setting-up-the-developer-environment) in the online documentation for the complete set of steps required.

Using Dev Containers however, we can remove a substantial amount of the process while at the same time ensuring a consistent development method used by the team. The DockerFile included allows control over what dependencies are used by the developers while also allowing initialisation activities to occur when the Docker container is built. This results in a much simpler way to go from zero to hero:

1. Clone this [powerbi-visuals-dev](https://github.com/slamb2k/powerbi-visuals-dev) repo.
2. Install the [Visual Studio Code Remote - Containers extension](https://code.visualstudio.com/docs/remote/containers) and pre-requisites.

3. Open VS Code in the local folder. When VS Code detects the .devcontainer folder it will offer to open the session using the DockerFile instead. 

   ![](/images/start-dev-container.png)

   Click "Reopen in Container" and the session will restart but instead be running from a local Docker container.

   ![](/images/vscode-docker.png)

   The Docker tools in VS Code show the current containers and images that are currently available on the system.

4. Since the dependencies are already included in the container image, we can simply bootstrap a visual project with ***pbiviz new <PROJECT_NAME>***.

   ![](/images/new-pbiviz.png)

   *The container includes a .gitignore that will prevent any of the build artifacts used for live preview from being added to Git.*

   *Ports to be forwarded for live preview (8080/tcp) have been specified in dockercontainer.json configuration.*


5. Change to the new folder created for the visual project and activate the development server with the command ***pbiviz start***.

6. A development certificate has already been created for you when the docker container was built. As this isn't a certificate from a trusted authority, when we open the web page, we will receive a response like so.
 
   ![](/images/cert-fail.png)

   We need to explictly do so on this development environment. Believe it or not, I find the easiest way is from good old Internet Explorer. 
   
   ***Run IE as Administrator*** and open the development server at https://localhost:8080/webpack-dev-server/.
 
   ![](/images/cert-ie.png)

   Click ***Certificate Error*** and then ***Certificate Information*** to open the certificate installation wizard. Ensure that you install the certificate to the ***Local Machine*** store and add it to the Trusted Root Certification Authority store. Once you refresh, you should now receive a response more like so:

   ![](/images/cert-good.png)

## Custom Visual Development ##

From this point the guidance on creating a custom visual for PowerBI works just fine. Refer to [Creating a custom visual](https://docs.microsoft.com/en-au/power-bi/developer/visuals/custom-visual-develop-tutorial#creating-a-custom-visual) for the steps required to have a simple working example of a custom visual running in just a few more minutes.

   ![](https://docs.microsoft.com/en-au/power-bi/developer/visuals/media/custom-visual-develop-tutorial/resize-visual.png)

## What's Next ##

Since we've now got a sweet SOE for our custom visual developers, we should also look at rubbing a little DevOps on the rest of the process. Some example items we may explore further:

1. Pipelines to build and test the actual custom visuals we create.

2. I haven't had much luck in finding a programmatic or scriptable method for registering the custom visuals with the organizational store or the Marketplace. I will investigate and hopefully something exists to allow Continuous Delivery of our visuals just like any other software project.

3. Automated pipelines to build, test and publish our SOE container image to ACR. I always prefer immutability when possible but we'll have to explore how well that works with the VS Code Remote - Containers extension.

