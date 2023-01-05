using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using EasyPay.Model.Dto;
using EasyPay.Model.EntityFrameWork;
using EasyPay.Service.Interface;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

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

            return Ok("Ok!!!\n");
        }
    }

    [Route("api/[controller]")]
    public class ProductController : Controller
    {

        private readonly IProductService _iProductService;

        public ProductController(IProductService iProductService)
        {
            _iProductService = iProductService;
        }

        // GET: api/<controller>
        [HttpGet]
        public async Task<IActionResult> Get()
        {
            try
            {
                var products = await _iProductService.GetProductsAsync();
                return Ok(products);
            }
            catch(Exception ex)
            {
                return BadRequest(ex.Message);
            }
            
        }

        [HttpGet("{productId}")]
        public async Task<IActionResult> Get(int productId)
        {
            try
            {
                var product = await _iProductService.GetProductAsync(productId);

                if (product == null)
                {
                    return NotFound();
                }

                return Ok(product);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }



    }
}
