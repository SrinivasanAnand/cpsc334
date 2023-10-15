public class bar {
  // vertical foos bar with display, bounce, and move functionality
  // takes x position of bar, width and height of boxes on bar
  // number of boxes, spacing of boxes, bar color, box color, and an 
  // offset index which is used for implementing move functionality
  
  int bar_x, box_x, box_y, spacing, num_boxes;
  int half_x, half_y, x_center, box_1_y_center, box_2_y_center, box_3_y_center;
  float y_offset;
  int offset_index;
  boolean charged;
  color bar_color, box_color;
  
  bar(int bar_x, int x, int y, int num_boxes, int spacing, color bar_color, color box_color, int offset_index) {
    this.bar_x = bar_x;
    this.box_x = x;
    this.box_y = y;
    this.num_boxes = num_boxes;
    this.spacing = spacing;
    this.bar_color = bar_color;
    this.box_color = box_color;
    
    this.x_center = edgex + this.bar_x;
    this.half_x = this.box_x / 2;
    this.half_y = this.box_y / 2;
    this.box_1_y_center = edgey + this.spacing + this.half_y;
    this.box_2_y_center = edgey_end - this.spacing - this.half_y;
    this.box_3_y_center = (box_1_y_center + box_2_y_center) / 2;
    
    this.y_offset = y_offsets[offset_index];
    this.charged = charges[offset_index];
    this.offset_index = offset_index;
    
    this.displayBar();
    this.updateBounce();
  }
  
  void displayBar() {
    // Displays bar include veritcal bar and
    // num_boxes boxes. Called upon initialization
    // of bar.
    
    int x_center = edgex + this.bar_x;
    
    stroke(this.bar_color);
    line(x_center, edgey, x_center, edgey_end);
    noStroke();
    
    fill(this.box_color);
    if (charged) {
      stroke(255, 234, 0);
    }
    rect(this.x_center + this.half_x, this.box_1_y_center + this.half_y + this.y_offset,
    this.x_center - this.half_x, this.box_1_y_center - this.half_y + this.y_offset);
    rect(this.x_center + this.half_x, this.box_2_y_center + this.half_y + this.y_offset,
    this.x_center - this.half_x, this.box_2_y_center - this.half_y + this.y_offset);
    
    if (this.num_boxes == 3) {
      rect(this.x_center + this.half_x, this.box_3_y_center + this.half_y + this.y_offset,
    this.x_center - this.half_x, this.box_3_y_center - this.half_y + this.y_offset);
    }
    noStroke();
    
  }
  
  void updateBounce() {
    // Updates velocity of ball if it is in contact
    // with the bar object.
    
    updateBoxReflection(this.x_center + this.half_x, this.box_1_y_center + this.half_y + y_offset,
    this.x_center - this.half_x, this.box_1_y_center - this.half_y + y_offset, this.charged);
    updateBoxReflection(this.x_center + this.half_x, this.box_2_y_center + this.half_y + y_offset,
    this.x_center - this.half_x, this.box_2_y_center - this.half_y + y_offset, this.charged);
    
    if (this.num_boxes == 3) {
      updateBoxReflection(this.x_center + this.half_x, this.box_3_y_center + this.half_y + 0.1 + y_offset,
    this.x_center - this.half_x, this.box_3_y_center - 0.1 - this.half_y + y_offset, this.charged);
    }
    
  }
  
  void move(float x, float speed) {
    // moves bar vertically up or down 'x' times 'speed' units
    
    y_offsets[this.offset_index] += x * speed;
    if (y_offsets[this.offset_index] > this.spacing) {
      y_offsets[this.offset_index] = this.spacing;
    }
    else if (y_offsets[this.offset_index] < -this.spacing) {
     y_offsets[this.offset_index] = -this.spacing; 
    }

    
  }
  
  
  
}
