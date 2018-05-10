function LetterCapitalize(str) { 
      let words = str.split(' ');
      str = '';
      for ( let i =0 ; i<words.length; i++){
        words[i] = words[i].charAt(0).toUpperCase() + words[i].slice(1);
      }
      return (words.join(' ')); 
             
    }
       
    // keep this function call here 
   console.log( LetterCapitalize("hello world"));                            
    