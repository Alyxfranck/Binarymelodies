 int binaryIndex = 0;
float colorStep;


void setup() {
  size(5000, 5000);
  String[] lines = loadStrings("binaryData.txt");
  String binaryString = join(lines, ""); 
  float[] binaryData = new float[binaryString.length()];
  for (int i = 0; i < binaryData.length; i++) {
    binaryData[i] = binaryString.charAt(i) == '0' ? 0 : 1;
  }
  
  // Generiere einen Seed basierend auf den binären Daten
 long seed = binaryString.hashCode();
 randomSeed(seed); // Initialisiere den Zufallsgenerator mit dem Seed
  
    
  draw(binaryData);
  
  save("output.png");
}

void draw(float[] binaryData) {
  noFill();
  beginShape();

 for (int i = 0; i < binaryData.length - 72; i += 72) { // 72 bits at a time
    float x1 = binaryToDecimal(binaryData, i, 8) / 255.0 * width; // Start/End x
    float y1 = binaryToDecimal(binaryData, i + 16, 8) / 255.0 * height;// Start/End y 
    int r = round(binaryToDecimal(binaryData, i + 24, 8)); 
    int g = round(binaryToDecimal(binaryData, i + 32, 8)); 
    int b = round(binaryToDecimal(binaryData, i + 40, 8)); 
    float cx1 = binaryToDecimal(binaryData, i + 48, 8) / 255.0 * height; 
    float cx2 = binaryToDecimal(binaryData, i + 56, 8) / 255.0 * height; 
    float cy1 = binaryToDecimal(binaryData, i + 64, 8) / 255.0 * width; 
    float cy2 = binaryToDecimal(binaryData, i + 72, 8) / 255.0 * width;

    float chance = random(1);
    if (chance < 0.1) { // 10% chance to apply color
      fill(r, g, b, 127); // fill color with transparency
    } else {
      noFill(); // no fill for grayscale curves
    }
    
    stroke(0);
    
   
    bezier(x1, y1, cx1, cy1, cx2, cy2, x1, y1);
  
}

  endShape();
}

int binaryToDecimal(float[] binaryData, int startIndex, int length) {
  int decimal = 0;
  for (int i = 0; i < length; i++) {
    decimal += binaryData[startIndex + i] * pow(2, length - i - 1);
  }
  return decimal;
}
