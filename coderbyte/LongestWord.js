function LongestWord(sen) { 
  //arr = sen.toString().split(' ');
  arr = sen.match(/\w+/g);
  let word1 = arr[0];
  for (var word of arr){
      //console.log(word);
      if ( word.length > word1.length ){
          word1 = word;
      }
  }
  return word1; 
}

LongestWord('a beautiful sentence');  