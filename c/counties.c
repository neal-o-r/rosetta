#include <stdlib.h>
#include <string.h>
#include <stdio.h>

int max_line_len = 100;
int n_counties = 32;
int n_words = 172819;

int readFile(FILE *fp, char **data, int lines_allocated) {
	if (data==NULL) {
      fprintf(stderr,"Out of memory (1).\n");
      exit(1);
    }

    if (fp == NULL) {
        fprintf(stderr,"Error opening file.\n");
        exit(2);
    }
	int i;
    for (i=0;i < lines_allocated; i++) {
        int j;

        /* Allocate space for the next line */
        data[i] = malloc(max_line_len);
        if (data[i]==NULL)
            {
            fprintf(stderr,"Out of memory (3).\n");
            exit(4);
            }
        if (fgets(data[i], max_line_len-1, fp)==NULL)
            break;

        /* Get rid of CR or LF at end of line */
        for (j=strlen(data[i])-1;j>=0 && (data[i][j]=='\n' || data[i][j]=='\r');j--)
            ;
        data[i][j+1]='\0';
        }

    fclose(fp);
	return 0;

}

int commonCharacters(char * word1, char * word2) {
  int i, j;

  if(word1 == NULL || word2 == NULL){
	return 0;
  }

  for(i=0; i < strlen(word1); i++) {
    for(j = 0; j < strlen(word2); j++) {
        if(word1[i] == word2[j]) {
		  return 1;
		}
    }
  }
  return 0;
}

int countCommonCharacters(char* word, char** counties) {
  int counter = 0;
  int i;

  for(i=0; i < n_counties; i++) {
    if(commonCharacters(word, counties[i]) == 1) {
		counter++;
	}
  }
  return counter;

}

int longestMatchIndex(char** counties, char** words) {
	int index = 10;
	int i;

	for(i=0; i < n_words; i++) {
	  if((countCommonCharacters(words[i], counties) == 31)
	  && (strlen(words[i]) > strlen(words[index]))) {
				index = i;
		}
	}
	return index;
}


int main() {
	char **counties = (char **)malloc(sizeof(char*)*n_counties);
	char **words = (char **)malloc(sizeof(char*)*n_words);
	readFile(fopen("data/counties.txt", "r"), counties, n_counties);
	readFile(fopen("data/enable1.txt", "r"), words, n_words);

	int index = longestMatchIndex(counties, words);
	printf("%d, %s\n", index, words[index]);
}
