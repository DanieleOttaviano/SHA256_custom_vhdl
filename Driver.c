#include "Driver.h"

void Initialize(volatile MS_Axi_t ** MS, const uint8_t Axi_Type){

	if(Axi_Type == AXI_FULL) *MS = (MS_Axi_t *)MS_BASE_FULL_ADDRESS;
	else if(Axi_Type == AXI_LITE) *MS = (MS_Axi_t *)MS_BASE_LITE_ADDRESS;
	else printf("Aurevoir\n");
}

void Write(volatile uint32_t * Address, const uint32_t Data){
	*Address = Data;
}

uint32_t Read(const volatile uint32_t * Address){
	return *Address;
}

void Deinitialize(volatile MS_Axi_t ** MS){
	*MS = 0x00000000;
}

void SHA_Compression(volatile MS_Axi_t * MS, const uint32_t * W, uint32_t * result){

	//Step 1 : Write the Matrix into the Peripheral Memory

	for(int i = 0; i < 64; i++){
		Write(&MS->W[i],W[i]);
	}

	//Step 2 : Start the compression by writing to the CR

	Write(&MS->CR, 0x00000001);

	//Step 3 : Check the Status Register in Polling
	while(Read(&MS->SR) == 0x00000000);

	//Step 4 : Clean the SR and get the Digest

	for(int i = 0; i < 8; i++){
		result[i] = MS->Digest[i];
	}

	Write(&MS->SR,0x00000000);

}
