function CorrectPath(str) { 

    // code goes here  
    return str; 
           
  }
  
  let maxX = 5;
  let maxY = 5;
  let tempStr = '';
  let  endNodeArr = new Array();
  
  function IsitmyFamily(id, parent) {
      //console.log( id, parent);
      if (parent === undefined) { // I dont have a parent
          return false;
      } else if (id == '11') { // Its the starting Node why waste time
          return true;
      } else if (id == parent.id) {  // Is it me 
          return true;
      } else if (parent.id == '11') { // Its the starting Node why waste time
          return false;
      }
      return (IsitmyFamily(id, parent.parent));
  }
  
  function isMax(X, Y) {
      if (X > maxX || Y > maxY || X < 1 || Y < 1) {
          return true;
      }
  }
  
  function buildPathsTree(X, Y, parent , approch) {
      if (isMax(X, Y)) { return undefined };
      if (IsitmyFamily(X + '' + Y, parent)) { return undefined };
      return (new Node(X, Y, parent, approch));
  }
  
  function Node(X, Y, parent,approch) {
      this.id = X + '' + Y;
      this.approch = approch;
      this.parent = parent;
      if (!(X == maxX && Y == maxY)) {
          this.left = buildPathsTree(X - 1, Y, this , 'l');
          this.right = buildPathsTree(X + 1, Y, this, 'r');
          this.up = buildPathsTree(X, Y - 1, this, 'u');
          this.down = buildPathsTree(X, Y + 1, this, 'd');
      }else{
          endNodeArr.push(this);
      }
  }
  function CorrectPath(str){
    let actaulPath = '';
      let patStr = "^" + str.split('?').join('.') + "$";
      
      endNodeArr.forEach(node => {
          tempStr = '';
          let pathstr = Reverse(findthePath(node)).slice(1);
  
          if (pathstr.match(patStr) != undefined ){
              //console.log (pathstr ) ;
              actaulPath = pathstr;
          }
          
      });
      return actaulPath;
  }
  
  function findthePath(node){
      tempStr += node.approch;
      if ( node.id != '11'){
          findthePath(node.parent);
      }
      return tempStr;
  }
  
  function Reverse(str) { 
      let arr = str.toString().split('');
      str = '';
      for ( let i=arr.length-1;i>=0;i--){
          str = str + arr[i];
      }
      return str; 
             
    }
  
  let root = buildPathsTree(1, 1, undefined , 'o');
  str = "drdr??rrddd?";
  console.log(CorrectPath(str));
  
       
  
  
     
  // keep this function call here 
  //CorrectPath(readline());                            
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
                              
                              
                              
    