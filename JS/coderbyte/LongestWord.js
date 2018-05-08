function LongestWord(sen) { 
  arr = sen.toString().split(' ');
  let word1 = arr[0];
  for (var word of arr){
      if ( word.length > word1.length ){
          word1 = word;
      }
  }
  return word1; 
}

LongestWord('I am Genome');  