class ControlFrame extends PApplet {

  int w, h;
  PApplet parent;
  ControlP5 cp5;
  int shift=300;

  public ControlFrame(PApplet _parent, int _w, int _h, String _name) {
    super();   
    parent = _parent;
    w=_w;
    h=_h;
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
  }

  public void settings() {
    size(w, h);
  }

  public void setup() {
    surface.setLocation(10, 10);
    cp5 = new ControlP5(this);

    cp5.addSlider("RANDOMIZER")
      .plugTo(parent, "rando")
      .setRange(0, 1000)
      .setValue(0)
      .setPosition(120, h-150)
      .setSize(200, 30);

    cp5.addSlider("SIZE")
      .plugTo(parent, "c3")
      .setRange(10, 1000)
      .setValue(100)
      .setPosition(120, h-190)
      .setSize(200, 30);

    cp5.addSlider("IMAGE")
      .plugTo(parent, "brush")
      .setRange(0, myEmos.length-1)
      .setValue(14)
      .setPosition(30, h-110)
      .setSize(290, 30);


    cp5.addSlider("Angle")
      .plugTo(parent, "a")
      .setRange(0, 1440)
      .setValue(720)
      .setPosition(30, h-220)
      .setSize(290, 20);

    cp5.addColorWheel("COLOR", 30, h-190, 80 ).setRGB(color(50, 50, 200)).setCaptionLabel("");
  }


  void draw() {
    background=color(cp5.get(ColorWheel.class, "COLOR").getRGB());
    background=color(background);
    background(background);

    //text("Cleared is " + clearIt, 30, h-10);

if(mouseY>height/2){
 textSize(20);
    text("Press C to clear the canvas and apply the", 30, h-115-shift);
    text("new background color", 30, h-95-shift);
    text("Use [ and ] to change the emoji", 30, h-75-shift);
    text("Use - and = to change its size", 30, h-55-shift);
    text("Use , and . to randomize", 30, h-35-shift);
    text("Use e and r to change its angle", 30, h-15-shift);
    text("Press S to smudge the image", 30, h-295);
}

    if (start==true) {
      pushMatrix(); 
      translate(w/2, 150);
      rotate(radians(a));
      imageMode(CENTER);
      image(myEmos[int(brush)], 0, 0, c3+soundForce, c3+soundForce);
      popMatrix();
    }
    cp5.getController("IMAGE").setValue(brush); 
    cp5.getController("SIZE").setValue(c3);
    cp5.getController("RANDOMIZER").setValue(rando);
  //  cp5.getController("React").setValue(int(music));
    cp5.getController("Angle").setValue(a);
    //cp5.getController("Rotate").setValue(int(rotate));



  }
}
