#### R ũ�Ѹ� ����

# install.packages("rvest")
library(rvest)

# ���̹����� �ð��Ѿ� ������ �ְ� ������ �����ϴ� �� �ּ�
url <- "https://finance.naver.com/sise/sise_market_sum.nhn"

# read_html() �Լ��� �־��� �� �ּҿ��� html������ �о xml ������ ����
html <- read_html(url, encoding = "euc-kr")

# html_nodes() �Լ��� �̿��Ͽ� table ��带 ����
# table�� ��� 3��
tables <- html %>% html_nodes("table") 
length(tables)

# tables�� ����Ͽ� Ȯ���ϸ� ������ ����
# ù ��° ���̺����� ������ �� �ִ� �׸���� ��Ƴ��Ҵ�
# �� ��° ���̺����� 50�� �ֽ�ȸ�翡 ���� �����̴�
# �� ��° ���̺��� ������ �׺���̼� ����Ʈ�̴�
# �� ��° ���̺��� �����͸� �������ڴ�
# ���̺��� �� ���� �����ʹ� td �±� ���̿� �ִ�

sise <- tables[2] %>% html_nodes("td"); sise

# ȸ��� �� 50���ε� td�� �� 681���̴�
# �� ������� �����Ͱ� ������ �̸� ������ �ʿ䰡 �ִ�
# html_text() �Լ��� �±� ���� �����͸� �����ϰ� ������ Ȯ���Ѵ�

data <- sise %>% html_text(); data

# �� �׸񿡼� "\n" �Ǵ� "\t"�� �����ؾ� �Ѵ�
# # gsub() �Լ��� "\t"�� ��� ""���� �����Ͽ� ��������
# "\"�� �̽������� �����̹Ƿ� ������ ����� ������ "\t"�� "\\t"�� ǥ���ؾ� �Ѵ�

data_t <- gsub("\\t", "", data); data_t
data_n <- gsub("\\n", "", data_t); data_n

# ���̺����� �� ���� ��ĭ("")�� �ƴ� �׸� ����

data <- data_n[data_n != ""]
length(data)

# ������ Ȯ���ϸ� ��� 600���̴�
# 50���� ������ 12�̴�
# �� ȸ��� 12���� ������ �����Ǿ� �ִ�
 
#  ���� ���� 12�� ��ķ� ���� �� ������ ���������� ��ȯ�Ѵ�
sise_df <- data.frame(matrix(data, ncol = 12, byrow = TRUE)); sise_df

# ���� �̸��� �����Ѵ�
item_name <- c("N",	"�����", "���簡", "���Ϻ�", "�����",
               "�׸鰡", "�ð��Ѿ�", "�����ֽļ�", 
               "�ܱ��κ���", "�ŷ���", "PER", "ROE")

names(sise_df) <- item_name

# ���� �ȿ� �ִ� �޸�(,)����
for(i in c(3, 4, 6, 7, 8, 10)){
    sise_df[[i]] <- gsub(",", "", sise_df[[i]])
}

#### ȸ�纰 �� �ֽ� ���� ���
url <- "https://finance.naver.com/sise/sise_market_sum.nhn"
html <- read_html(url, encoding = "euc-kr")
tables <- html %>% html_nodes("table")
tables

# �� ��° ���̺����� "a" �±� �ȿ��� �Ӽ� "href"�� ���� html_attr() �Լ��� �����Ѵ�
hrefs <- tables[2] %>% html_nodes("a") %>% html_attr("href"); hrefs

# ������ 6�ڸ� ���ڰ� ���� �ڵ��̴�
# substr() �Լ��� ������ ���� 6���� �����Ѵ�
# nchar() �Լ��� ���ڿ� ������ ���Ѵ�
codes <- substr(hrefs, nchar(hrefs)-5, nchar(hrefs)); codes   

# ���� �ڵ尡 �ߺ��Ǿ����� Ȧ�� �����͸� ��������
stock_code <- codes[c(TRUE, FALSE)]
    
## Tip
# class�� .�� �տ� ���̰� id�� #�� �տ� ���̸� �ȴ� 

