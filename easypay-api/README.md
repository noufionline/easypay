## Project Used (Asp.net Core Web API + Postgresql Database)


**EasyPay.WebApi**

- Tables and sample data are scaffolded when the Web Api Projects runs for the first time.
- Using docker build command images is built

![docker build](https://github.com/noufionline/easypay/blob/main/execution-info/images/k8s/api/Docker%20build%20image.png)

- Using docker push command image is pushed to docker hub

![docker push](https://github.com/noufionline/easypay/blob/main/execution-info/images/k8s/api/Docker%20push%20to%20docker%20hub.png)

- Docker image is pulled from [noufionline/easypay:2.0](https://hub.docker.com/r/noufionline/easypay) 

```
docker pull noufionline/easypay:2.0
```

![Docker hub](https://github.com/noufionline/easypay/blob/main/execution-info/images/k8s/api/easypay%20image%20on%20docker%20hub.png)


**EasyPay.Test**

- Project contains Tests for the controllers used in project
  1. ProductController
  2. ShoppingCartController
  
 ![Product Controller Test Class](https://github.com/noufionline/easypay/blob/main/execution-info/images/k8s/api/Product%20Test%20Class.png)
  
 ![Test Results Window](https://github.com/noufionline/easypay/blob/main/execution-info/images/k8s/api/Test%20Results%20window.png)
  
  
- To escalate CPU Utilization a seperate controller provided

```
using System;
using Microsoft.AspNetCore.Mvc;


// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace EasyPay.WebApi.Controllers
{

    [Route("api/increase-cpu-load")]
    public class CpuLoadController: Controller{
        [HttpGet]
        public IActionResult Get(){
            double x=0;
            for(var i=0;i<=1000000; i++){
                x+=Math.Sqrt(i);
            }

            return Ok("Ok!!!");
        }
    }
}

```
