#include <stdlib.h>
#include <string.h>
#include <stdio.h>

int max_line_len = 32;
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
        /* Get rid of CR or LF at end of line */
		fgets(data[i], max_line_len-1, fp);
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

int firstMatchIndex(char** counties, char** words) {
	int i;

	for(i=0; i < n_words; i++) {
	  if(countCommonCharacters(words[i], counties) == 31) {
	    return i;
	  }
	}
	return i;
}

int compare(const void *name1, const void *name2)
{
    const char *name1_ = *(const char **)name1;
    const char *name2_ = *(const char **)name2;
    if ( strlen(name1_) == strlen(name2_) ) return 0;
    else if ( strlen(name1_) < strlen(name2_) ) return 1;
    else return -1;
}

int main() {

    char **counties = (char **)malloc(sizeof(char*)*n_counties);
    char **words = (char **)malloc(sizeof(char*)*n_words);
	readFile(fopen("data/counties.txt", "r"), counties, n_counties);
	readFile(fopen("data/enable1.txt", "r"), words, n_words);

	qsort(words, n_words, sizeof(&words[0]), compare);

	int index = firstMatchIndex(counties, words);
	printf("%s\n", words[index]);
}
