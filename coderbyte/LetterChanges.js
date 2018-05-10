function LetterChanges(str) { 
    let arr = str.split('');
    let vlMap = new Map([['a','A' ],['e','E'],['i','I'],['o','O'],['u','U']]);

    function isChar(c){
        if (c.charCodeAt(0) > 96 && c.charCodeAt(0) < 123 ){
            return true;
        }
        return false;
    }
    function nextChar(c){

        if ( isChar(c)){
             if ( c.charCodeAt(0) ==122){
                return String.fromCharCode(97);
            }else{
                return (String.fromCharCode(c.charCodeAt(0)+1));
            }
        }
        else return (c);
    }
    str = '';
    for ( let i = 0 ; i< arr.length ; i++){
        c = nextChar(arr[i]);
        console.log(vlMap.has(c) + c);
        if ( vlMap.has(c)){
            
            c = vlMap.get(c);
        }
        str = str + c;
    }
    return str; 
           
  }
  // keep this function call here 
 console.log( LetterChanges("fun times!"));                            

  