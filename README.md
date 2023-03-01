![Image](https://i.ibb.co/NxtyJ3T/immudex2.png)

# IMMutable DEbian with Xfce

Immudex to wersja debian zawierająca niezmienne środowisko pracy. Wykorzystuje
ona bowiem archiwum .squashfs znane z LiveCD. Przyczym pozwala ona na pełen
dostęp do partycji zawierające archiwum, w razie aktualizacji. Tak przygotowana
wersja popularnego systemu operacyjnego pozwoli bezpieczniejsze korzystanie
z komputera oraz zasobów internetu. Jeśli coś się stanie, wystarczy uruchomić
komputer ponownie.

Immudex nastawiowny jest na wykorzystanie do przechowywania danych szyfrowanych
partycji za pomocą mechanizmu LUKS. Dodatkowy mechanizm pozwala na 
zabezpieczenie danych składowanych na tego typu partycjach, na przykład jeśli
mamy otwarte jakieś pliki na zaszyfrowanej partycji przeglądarka się nie
uruchomi. Musimy wówczas zamknąć wszystkie pliki oraz opuścić punkt montowania
szyfrowanej partycji, wtenczas zostanie ona odmontowana szyfrowany wolumin
zostanie zamknięty. Po tych czynnościach przeglądarką uruchomi się
samodzielnie. W ramach bezpieczeństwa dostępny jest również sandboxer FireJail,
zablokowano również wszelkie sieciowe połączenia przychodzące.

Immudex domyślnie korzysta z wolnego oprogramowania, nie zainstalowano na nim
niewolnych pakietów, w konfiguracji nie ma również niewolnych repozytoriów.
Do dyspozycji mamy:
  * Standardowe środowisko XFCE dostępne na Debian Stable
  * Odtwarzacz muzyki QMMP
  * Odtwarzacz multimedialny VLC
  * virt-manager (KVM)

Obraz płyty znajduje się na serwisie sourceforge.net. Poniżej znajduje się 
odnośniki.

**Ze względu na zmianę serwera dystrybuującego immudex, do aktualizacji systemu
do wersji 0.1.0 należy użyć skryptu immudex_upgrade z katalogu tools/010 lub
przeprowadzić aktualizacje ręcznie. Skrypt aktualizacji zawarty w wersji 0.0.9
nie będzie działać.**

  * 64-bit: [https://ftp.morketsmerke.org/immudex/stable/iso/0.1.0/immudex64.iso](https://ftp.morketsmerke.org/immudex/stable/iso/0.1.0/immudex64.iso)
    CRC: 2356080590 SHA1: da6971fc1605cdf11f16d24116fa626cfe969a9a
  * 32-bit: [https://ftp.morketsmerke.org/immudex/stable/iso/0.1.0/immudex32.iso](https://ftp.morketsmerke.org/immudex/stable/iso/0.1.0/immudex32.iso)
    CRC: 3179597757 SHA1: bc4f720ff313dbbcd2b6c7f0380863a396a2f55b

Domyślnym użytkownikiem jest user, dostęp to niego uzyskujemy za pomocą hasła
user1. Możemy również skorzystać z konta superużytkownika root z hasłem toor.

immudex is not affiliated with Debian. Debian is a registered trademark owned 
by Software in the Public Interest, Inc.

[Lock icons created by Freepik - Flaticon](https://www.flaticon.com/free-icons/lock)

[Rss icons created by Freepik - Flaticon](https://www.flaticon.com/free-icons/rss)
 
