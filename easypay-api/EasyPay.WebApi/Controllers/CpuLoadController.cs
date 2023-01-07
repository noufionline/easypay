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