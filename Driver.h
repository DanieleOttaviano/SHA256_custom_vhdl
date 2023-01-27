#include <stdio.h>

#define MS_BASE_FULL_ADDRESS 0x7AA00000 //Base Address for the peripheral, Axi Full version - MS W MEMORY REGION - 256 BYTE
#define MS_DIGEST_FULL_ADDRESS 0x7AA00100 //MS Digest Memory region - 32 BYTE
#define MS_CR_FULL_ADDRESS 0x7AA00120 //Control register memory region - 4 BYTE
#define MS_SR_FULL_ADDRESS 0x7AA00124 //Status register memory region - 4 BYTE
#define MS_VR_FULL_ADDRESS 0x7AA00128 //Version register memory region - 4 BYTE
#define MS_RESERVED_FULL_ADDRESS 0x7AA00132 //RESERVED

#define MS_BASE_LITE_ADDRESS 0x43C00000 //Base Address for the peripheral, Axi Lite version - MS W MEMORY REGION - 256 BYTE
#define MS_DIGEST_LITE_ADDRESS 0x43C00100 //MS Digest Memory region - 32 BYTE
#define MS_CR_LITE_ADDRESS 0x43C00120 //Control register memory region - 4 BYTE
#define MS_SR_LITE_ADDRESS 0x43C00124 //Status register memory region - 4 BYTE
#define MS_VR_LITE_ADDRESS 0x43C00128 //Version register memory region - 4 BYTE
#define MS_RESERVED_LITE_ADDRESS 0x43C00132 //RESERVED

#define AXI_LITE 0
#define AXI_FULL 1

typedef struct{
	uint32_t W[64];
	uint32_t Digest[8];
	uint32_t CR;
	uint32_t SR;
	uint32_t VR;
	uint32_t Reserved[0xFFFF-0x0136+0x0001];
}MS_Axi_t;

void Initialize(volatile MS_Axi_t **, const uint8_t );

void Write(volatile uint32_t *, const uint32_t );

uint32_t Read(const volatile uint32_t *);

void Deinitialize(volatile MS_Axi_t **);

void SHA_Compression(volatile MS_Axi_t *, const uint32_t *, uint32_t *);
