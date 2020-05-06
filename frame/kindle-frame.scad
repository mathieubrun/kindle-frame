

kindle_w=114.5;
kindle_h=165;
kindle_d=8.8;

kindle_screen_w=90;
kindle_screen_h=122;

kindle_screen_offset=27;
kindle_offset=(kindle_screen_offset - (kindle_h - kindle_screen_h - kindle_screen_offset))/2;

kindle_buttons_w=55;
kindle_buttons_h=17;
kindle_buttons_d=1.1;

kindle_buttons_offset=6;

inner_frame_w=132;
inner_frame_h=182;
inner_frame_t=0.3*3;
inner_frame_blocker_t=2.6;
glass_t=2;
inner_frame_d=kindle_d + kindle_buttons_d + inner_frame_t;

blocker_t=0.3*8;

screw_distance=5;
screw_d=4;

screws=[
  [screw_distance, screw_distance, 0],
  [inner_frame_w - screw_distance, screw_distance, 0],
  [screw_distance, inner_frame_h - screw_distance, 0],
  [inner_frame_w - screw_distance, inner_frame_h - screw_distance, 0]
];

print=false;
open=false;
device=true;
part="";

if(print) {
  if(part=="inner_frame")
  inner_frame();

  if(part=="blocker")
  blocker();
  
  if(part=="back")
  back();
}
else
{
  inner_frame();

  translate([inner_frame_w + 10, 0, 0])
  blocker();
  
  translate([(inner_frame_w + 10)*2, 0, 0])
  back();
}

back_w=30;
back_r=3;
back_d=60;
back_h=inner_frame_h;
back_t=2;

module back() {
  difference() {
    minkowski(){
      translate([back_t ,back_t , 0])
      cylinder(r=back_t, h=1);
      _back(back_w-1);
    }
    
    translate([back_t ,back_t , 0])
    _back(back_w);
  }
}

module _back(h) {
  translate([back_r ,back_r , 0])
  hull() {
    for(i = [
      [0, 0, 0],
      [0, back_h - 2*back_r - 2*back_t, 0],
      [back_d - 2*back_r - 2*back_t, -10, 0],
      ]) {
      translate(i)
      cylinder(r=back_r, h=h);
    }
  }
}

module blocker() {
  difference() {
    union() {
      _cross();
      
      translate([1.25*screw_distance, screw_distance, 0])
      cube([inner_frame_w - 2.5*screw_distance, 2*screw_distance, blocker_t]);
      
      translate([1.25*screw_distance, inner_frame_h - 3*screw_distance, 0])
      cube([inner_frame_w - 2.5*screw_distance, 2*screw_distance, blocker_t]);
    }
    
    for(screw = screws) {
      translate(screw) {
        cylinder(r=1.65, h=inner_frame_d, $fn=30);
        cylinder(d=5.5, h=0.6, $fn=30);
      }
    };
    
    translate([(inner_frame_w - back_w - 1)/2, screw_distance, blocker_t / 2])
    cube([back_w + 1, inner_frame_h, blocker_t / 2]);
  }
}

module _cross() {
  intersection() {
    cube([inner_frame_w, inner_frame_h, blocker_t]);
  
    difference() {
      union() {
        translate([screw_distance, screw_distance, 0])
        rotate([0, 0, atan((inner_frame_h - 2*screw_distance) / (inner_frame_w - 2*screw_distance))])
        translate([-screw_distance * 2, -screw_distance, 0])
        cube([inner_frame_w * 2, 2*screw_distance, blocker_t]);
        
        translate([inner_frame_w, 0, 0])
        mirror([1,0,0])
        translate([screw_distance, screw_distance, 0])
        rotate([0, 0, atan((inner_frame_h - 2*screw_distance) / (inner_frame_w - 2*screw_distance))])
        translate([-screw_distance * 2, -screw_distance, 0])
        cube([inner_frame_w * 2, 2*screw_distance, blocker_t]);
      }
    }
  }
}

module inner_frame() {  
  difference() {
    cube([inner_frame_w, inner_frame_h, inner_frame_d-0.1]);
    
    translate([0, 4*screw_distance, inner_frame_blocker_t])
    cube([inner_frame_w, inner_frame_h - 8*screw_distance, inner_frame_d]);
    
    translate([4*screw_distance, 0, inner_frame_blocker_t])
    cube([inner_frame_w - 8*screw_distance, inner_frame_h, inner_frame_d]);
        
    for(screw = screws) {
      translate(screw) {
        cylinder(r=1.65, h=inner_frame_d, $fn=30);
        cylinder(r=3.2, h=inner_frame_d-6, $fn=6);
      }
    };
    
    translate([(inner_frame_w - kindle_w)/2, (inner_frame_h - kindle_h)/2 - kindle_offset, inner_frame_t])
    kindle(); 
  }
}

screen_tolerance=1;
module kindle() {
  union() {
    // body
    translate([0, 0, kindle_buttons_d])
    cube([kindle_w, kindle_h, kindle_d]);
    
    // buttons
    translate([(kindle_w - kindle_buttons_w)/2, kindle_buttons_offset, 0])
    cube([kindle_buttons_w, kindle_buttons_h, kindle_buttons_d]);
    
    // screen 
    translate([(kindle_w - kindle_screen_w - screen_tolerance)/2, kindle_screen_offset +    screen_tolerance/2, -1])
    cube([kindle_screen_w - screen_tolerance, kindle_screen_h-screen_tolerance, kindle_buttons_d + 1]);
    
    // holes
    translate([(kindle_w - kindle_w * 0.6)/2, -10, kindle_buttons_d])
    cube([kindle_w * 0.6, 20, kindle_d]);
  }
}