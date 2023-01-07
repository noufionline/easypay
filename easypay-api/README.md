## Project Used (Asp.net Core Web API + Postgresql Database)


**EasyPay.WebApi**

- Tables and sample data are scaffolded when the Web Api Projects runs for the first time.
- Using docker build command images is built
- Using docker push command image is pushed to docker hub
- Docker image is pulled from [noufionline/easypay:2.0](https://hub.docker.com/r/noufionline/easypay) 

```
docker pull noufionline/easypay:2.0
```


**EasyPay.Test**

- Project contains Tests for the controllers used in project
  1. ProductController
  2. ShoppingCartController
  
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
