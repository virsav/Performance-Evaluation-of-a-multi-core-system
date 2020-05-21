
#include <stdio.h>
#include <stdlib.h>
#include <pthread.h> // including pthread library

void *function( void *ptr ); //defining function 
int main()
{
     pthread_t threads[200]; // creating 200 threads array
     int  created[200];

for(int j=0;j<200;j++){
	created[j] = pthread_create( &threads[j], NULL,function,NULL); // creating 200 threads
	pthread_join( threads[j], NULL); // waiting fro threads to finish their task and joining them
	printf("Thread is %d created: %d\n",j,created[j]); 
}

     exit(0);
     return 0;
}

void *function( void *ptr )
{

long int *pointer,max=0,sum=0;	
int temp;
pointer=(long int *) calloc(2100000,sizeof(long int)); //allocating array of size 16MB
if(pointer==NULL){
printf("space allocation failed");}

    int high =9999999,low=10;
    int num = ((rand()%(high - low + 1)) + low);
    for(int i=0;i<2100000;i++){
            *(pointer+i)=(long int)num;
    }
     for(temp=0;temp<2100000;temp++){
                sum+=*(pointer+temp); //finding sum of all the elements in the array
 
    }
    printf("sum is %ld\n",sum);

   printf("%ld\n",sizeof(long int)*(temp));
	free(pointer); //freeing the malloc memory pointer

  
}
