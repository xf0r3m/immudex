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

### Zmiany jakich należy dokonać przed stworzeniem obrazu płyty.

1. Usuń użytkowników testowych:
  ```
  userdel -r user
  userdel -r xf0r3m
  ```
2. Usuń wpisy dla tych użytkowników z pliku `/etc/sudoers`:
  ```
  sed -i -e '/^user/d' -e '/^xf0r3m/d' /etc/sudoers
  ```
3. Utwórz swojego użytkownika:
  ```
  useradd -m -s /bin/bash *nazwa-użytkownika*
  passwd *nazwa-użytkownika*
  usermod -aG sudo,libvirt,libvirt-qemu *nazwa-użytkownika*
  ``` 
4. Zablokuj możliwość logowania się na superużytkownika:
  ```
  usermod -L root
  ```
**Podpowiedź:** _Tę czynność można skrócić, odnajdując wywołanie funkcji `recreate_user`, wyłączając je
za pomocą komentarza (`#`) i zapisując zamiast go polecenia z pkt. `3` oraz `4`._

### Tworzenie obrazu płyty dystrybucji:
  
  ```
  $ git clone https://github.com/xf0r3m/immudex
  $ cd immudex-testing
  $ ./immudex-build --<amd64/i386> --<testing/stable/oldstable>
  ```

### Zastrzeżenia i uznanie autorstwa:

immudex is not affiliated with Debian. Debian is a registered trademark owned 
by Software in the Public Interest, Inc.
