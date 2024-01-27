%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
struct Node {
char* label;
int num;
struct Node* left;
struct Node* right;
};
struct Node* createNode(const char* label, int num, struct Node* left, struct
Node* right)
{
struct Node* node = (struct Node*)malloc(sizeof(struct Node));
node->label = strdup(label);
node->num = num;
node->left = left;
node->right = right;
return node;
}
void printInorder(struct Node* node) {
if (node == NULL) return;
printInorder(node->left);
if (node->label != NULL) printf("%s ", node->label);
else printf("%d ", node->num);
printInorder(node->right);
}
%}
%token NUMBER
%union {
int num;
struct Node* node;
}
%type <num> NUMBER
%type <node> s E T F
%start s
%%
s: E {
printf("The result is = %d\n", $1->num);
printf("Parse Tree (Inorder): ");
printInorder($1);
printf("\n");
freeTree($1);

}
;
E: E '+' T {
$$ = createNode("+", $1->num + $3->num, $1, $3);
}
| T {
$$ = $1;
}
;
T: T '*' F {
$$ = createNode("*", $1->num * $3->num, $1, $3);
}
| F {
$$ = $1;
}
;
F: '(' E ')' {
$$ = $2;
}
| NUMBER {
$$ = createNode(NULL, $1, NULL, NULL);
}
;
%%
void freeTree(struct Node* node) {
if (node == NULL) return;
freeTree(node->left);
freeTree(node->right);
if (node->label != NULL) free(node->label);
free(node);
}
int main() {
yyparse();
return 0;
}
int yywrap() {
return 1;
}
void yyerror(const char* s) {
fprintf(stderr, "Error: %s\n", s);
exit(1);
}