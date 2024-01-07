![Image](https://i.ibb.co/NxtyJ3T/immudex2.png)

# IMMutable DEbian with Xfce

## GNU/LINUX Debian (testing, stable i oldstable)

To repozytorium zawiera pliki służące do tworzenia dystrybucji immudex.
Zawiera ono wiele ciekawych informacji, jednak podstawowe infomacje na temat 
tej dystrybucji znajdują się pod adresem:

[https://morketsmerke.github.io/articles/immudex/immudex.html](https://morketsmerke.github.io/articles/immudex/immudex.html)

### Dodawanie zmian do obrazu płyty:

Aby dołączyć jakiekolwiek zmiany do obrazu płyty należy przed rozpoczęciem
procesu tworzenia obrazu płyty umieścić modyfikacje, przed poleceniem `tidy` w
pliku *versions/base.sh*.

### Zmiany jakich należy dokonać przed stworzeniem obrazu płyty:

Obecnie superużytkownik posiada losowe haslo oraz zablokowana
jest możliwość zalogowania się na niego. Dostęp do 'root' możemy
uzyskać za pomocą polecenia 'sudo su'.
Podstawowy użytkownik (z uprawnieniami sudo)
jest tworzony podczas budowania obrazu. Podejmowanie czynności
przed stworzeniem obrazu płyty nie jest póki co wymagane.

### Tworzenie obrazu płyty dystrybucji:
  
  ```
  $ git clone https://github.com/xf0r3m/immudex
  $ cd immudex
  $ ./immudex-build --<amd64/i386> --<testing/stable/oldstable>
  ```

### Zastrzeżenia i uznanie autorstwa:

immudex is not affiliated with Debian. Debian is a registered trademark owned 
by Software in the Public Interest, Inc.
