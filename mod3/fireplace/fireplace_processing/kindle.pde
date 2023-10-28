void grow(float x) {
  for (int i = 0; i < maxwaves; i++) {
    if (amplitude[i] + x < amp_max && amplitude[i] + x > amp_min) {
        amplitude[i] += x;
    }
  }
  if (touch_flag == true) {
    //println("replay mode, grew by " + x);
  }
  else {
    //println("normal mode, grew by " + x);
  }
  
}
