function FirstReverse(str) { 
    let arr = str.toString().split('');
    str = '';
    for ( let i=arr.length-1;i>=0;i--){
        str = str + arr[i];
    }
    return str; 
           
  }
     
  // keep this function call here 
  console.log(FirstReverse('i am Genome'));                            
  