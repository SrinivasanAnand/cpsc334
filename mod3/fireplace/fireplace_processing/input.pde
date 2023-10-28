void get_input(){
  String[] lines = loadStrings("/Users/anandsrinivasan/cpsc334/mod3/fireplace/log.txt");
  
  
  calibrate(lines);
  
  // println("there are " + lines.length + " lines");
  if (log_index < lines.length && touch_flag == false) {
    
    current_log_file_len = lines.length;
    // println("Line" + log_index + ": " + lines[log_index]);
    String line = lines[log_index];
    
    int[] light_ret = get_light_val(line);
    light_val = light_ret[0];
    touch_val = get_touch_val(line, light_ret[1]);
    
    log_index += 1;
  }
}

int[] get_light_val(String line) {
  String light_str = "";
  int offset = 0;
  while (line.charAt(msg_start + offset) != '|'){
    light_str = light_str + line.charAt(msg_start + offset);
    offset += 1;
  }
  int[] ret = new int[2];
  ret[0] = int(light_str);
  ret[1] = offset += 9; // for second value
  return ret;
}

int get_touch_val(String line, int offset) {
  String touch_str = "";
  while (line.charAt(msg_start + offset) != '|'){
      touch_str = touch_str + line.charAt(msg_start + offset);
      offset += 1;
  }
  return int(touch_str);
}

void calibrate(String[] lines) {
  if (calibrated == false && lines.length > 5) {
    int sum = 0;
    for (int i = 0; i < lines.length; i++) {
      sum += get_light_val(lines[i])[0];
    }
    calibration = (float) sum / (float) lines.length;
    calibrated = true;
    
    println("Calibration complete");
  }
}
void scale_input() {
  if (touch_val < touch_threshold) {
    touch_val_scaled = true;
  }
  else {
    touch_val_scaled = false;
  }
  if (calibrated == true) {
    light_val_scaled = 2 * (calibration - light_val) / calibration -0.3; 
  }
  else {
    light_val_scaled = 0;
  }
  
  
}

void replay() {
  if (touch_val_scaled == true) {
    touch_flag = true;
    log_index = current_log_file_len;
  }
  if (touch_flag == true) {
    String[] lines = loadStrings("/Users/anandsrinivasan/cpsc334/mod3/fireplace/log.txt");
    if (replay_count < log_index) {
      if (replay_count % 10 == 0) {
        wait_count -= 1;
        if (wait_count == 0) {
          replay_count += 1;
          wait_count = 1;
        }
      }
      else {
        int replay_val = get_light_val(lines[replay_count])[0];
        float replay_val_scaled = 2 * (calibration - replay_val) / calibration -0.3;
        if (repeat_count > 0) {
          grow(replay_val_scaled);
          repeat_count -= 1;
        }
        else {
          repeat_count = 8;
          replay_count += 1;
        }
      }
    }
    else {
      touch_flag = false;
      replay_count = 0;
      log_index += 25;
    }
    
  }
}
