

void calcWave() {
  // Increment theta (try different values for 'angular velocity' here
  theta += 0.02;

  // Set all height values to zero
  for (int i = 0; i < yvalues.length; i++) {
    yvalues[i] = 0;
  }
 
  // Accumulate wave height values
  for (int j = 0; j < maxwaves; j++) {
    float x = theta;
    for (int i = 0; i < yvalues.length; i++) {
      // Every other wave is cosine instead of sine
      if (j % 2 == 0)  yvalues[i] += sin(x)*amplitude[j];
      else yvalues[i] += cos(x)*amplitude[j];
      x+=dx[j];
    }
  }
}

void renderWave() {
  noStroke();

  ellipseMode(CENTER);
  for (int x = 0; x < yvalues.length; x++) {
    //stroke(b2, 120);
    ellipse(x*xspacing,6*height/7+yvalues[x],8,8);
    stroke(0);
    //line(x*xspacing, 0, x*xspacing, height/2+yvalues[x] + random(-5, 5));
    noStroke();
    fill(0);
    rect(x*xspacing, 0, 5, height/2+yvalues[x] + random(-5, 15));
    noFill();
  }
}
