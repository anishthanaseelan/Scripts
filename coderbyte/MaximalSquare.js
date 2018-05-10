function MaximalSquare(strArr) { 
  let size = 0;
  function hasZero(r1,c1,r2,c2, strArr){
   
    for ( let r=r1; r<r2 ;r++ ){
      for ( let c=c1; c<c2; c++){
        if (strArr[r][c] == 0  ){
          return true;
        }
      }
    }
    return false;
  }  
    //choose Node 
    for ( let r=0; r<strArr.length ;r++ ){
      for ( let c=0; c<strArr[0].length; c++){
        if (strArr[r][c] == 0 ){ continue;} // No need to proceed 
        for ( s=1; s<=strArr.length ; s++){
          if ( (r+s) > strArr.length ||  (c+s) > strArr[0].length ){ // Index out off bound
            break;
          }else if ( hasZero(r,c,(r+s),(c+s),strArr)){
             break;
          }else{
            if ( size < s ) { size = s; }
          }

        }
      }
    }

  
    return ( size*size); 
           
  }
     
  // keep this function call here 
  console.log(MaximalSquare(["0111", "1111", "1111", "1111"]));                            
