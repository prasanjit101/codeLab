#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

typedef uint8_t BYTE;

int main(int argc, char *argv[])
{

  if (argc != 3)
    {
        printf("Please pass the file name to be copied and the destination of copying only, as the commands ");
        return 1;
    }

    // File to be copied
    FILE *originalFile = fopen(argv[1], "r");
    if (originalFile == NULL)
    {
        printf("Could not open the file %s.\n", argv[1]);
        return 1;
    }

    // Location of copying
    FILE *destination = fopen(argv[2], "w");
    if (destination == NULL)
    {
        fclose(originalFile);
        printf("Could not create file %s.\n", argv[2]);
        return 1;
    }

    //Copying 1 Byte at a time 
    BYTE buffer;
    while (fread(&buffer, sizeof(BYTE), 1, originalFile))
    {
        fwrite(&buffer, sizeof(BYTE), 1, destination);
    }

    int status = remove(originalFile);//removing the source file

    // Close files
    fclose(originalFile);
    fclose(destination);
    return 0;
}
