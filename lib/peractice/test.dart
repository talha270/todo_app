
void main(){
  String a="fhgfjghjkertyuiuytrertyukhdcvbnmjhgfdertyuiiytedfghjkkdfghjknvcxzaqazsedfrfvtgyujk";
  Set filtered={};
  for(int i=0;i<a.length;i++){
    filtered.add(a[i]);
  }
  print(a);
  print(filtered);


  Map fil={};

  for(int i=0;i<a.length;i++){
    if(fil[a[i]]!=null){
      fil[a[i]]++;
    }else{
      fil[a[i]]=1;
    }
  }
  print(fil);

  int length = 0;

  // Iterate through each character in the string
  for (var c in a.runes) {
    length++;
  }
  print(a.length);
  print(length);

  // for(int i=0;i<a.length;i++) {
  //   if (filtered == "") {
  //     filtered += a[i];
  //   } else {
  //     int j=0;
  //     bool check=false;
  //     for (j = 0; j < filtered.length; j++) {
  //       if (a[i]==filtered[j]) {
  //         check=true;
  //         break;
  //       }else{
  //         check=false;
  //       }
  //     }
  //     if(!check){
  //       filtered+=a[i];
  //     }
  //   }
  // }
  // print(a);
  // print(filtered);
  // print(a.length);

}

// removeDuplicate(String str){
//   const result = "";
//   const usedChar = [];
//   for(int i=0; i<str.length; i++){
//       Word = str[i];
//      if(usedChar[Word]{
//        usedChar[Word]++;
//      }
//      else{
//        usedChar[Word] = 1;
//        result = result[Word]
//      return result;
//      }
  // }
// }