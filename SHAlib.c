#include "SHAlib.h"

void SHA256(char * text, uint32_t * Digest, const uint8_t AXI){

	uint32_t TextSize;
	uint32_t dim = 0;
	uint8_t Data[64];
	uint32_t W[64];
	uint32_t s0;
	uint32_t s1;

	MS_Axi_t * MS;

	while(text[dim] != '\0') dim++;
	TextSize = 8*dim;

	if(TextSize > 512-65 || dim > 32) printf("To be added....\n");
	else{
		for(int i = 0; i < 64; i++){

			if(i < dim){
				Data[i] = text[i];
			}
			else if (i == dim){
				Data[i] = text[i] | 0x80;
			}
			else if (i >= dim +1 && i < 64 - 1){
				Data[i] = 0x00;
			}
			else{
				Data[63] = TextSize;
			}
		}

		for(int i = 0; i < 64; i++){
			if(i < 16){
				W[i] = ((uint32_t)Data[i*4+3]) | ((uint32_t)Data[i*4+2] << 8) | ((uint32_t)Data[i*4+1] << 16) | ((uint32_t)Data[i*4] << 24);
			}
			else{
				W[i] = 0;
			}
		}

		for(int i = 16; i < 64; i++){
			s0 = (rightRotate(W[i-15],7)) ^ (rightRotate(W[i-15],18)) ^ (W[i-15] >> 3);
			s1 = (rightRotate(W[i-2],17)) ^ (rightRotate(W[i-2],19)) ^ (W[i-2] >> 10);
			W[i] = (W[i-16] + s0 + W[i-7] + s1)%4294967296;

		}

		Initialize(&MS,AXI);
		SHA_Compression(MS,W,Digest);
		Deinitialize(&MS);
	}



}

uint32_t rightRotate(uint32_t inputWord, uint32_t numberOfBitsToRotate) {
    int bitWidth = sizeof(inputWord) * 8;
    // Rotating 32 bits on a 32-bit integer is the same as rotating 0 bits;
    //   33 bits -> 1 bit; etc.
    numberOfBitsToRotate = numberOfBitsToRotate % bitWidth;

    uint32_t tempWord = inputWord;

    // Rotate input to the right
    inputWord = inputWord >> numberOfBitsToRotate;

    // Build mask for carried over bits
    tempWord = tempWord << (bitWidth - numberOfBitsToRotate);

    return inputWord | tempWord;
}
