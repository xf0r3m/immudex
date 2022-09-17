![Image](https://i.ibb.com/Nxtyj3T/immudex2.png)
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
  * 64-bit: [https://sourceforge.net/projects/immudex/files/iso/0.0.1/immudex64.iso/download](https://sourceforge.net/projects/immudex/files/iso/0.0.1/immudex64.iso/download)
    CRC: 1964822169 SHA1: b0fbf24169e1fc750914a0a8d5513b0a216b698e
  * 32-bit: [https://sourceforge.net/projects/immudex/files/iso/0.0.1/immudex32.iso/download](https://sourceforge.net/projects/immudex/files/iso/0.0.1/immudex32.iso/download)
    CRC: 1128213029 SHA1: b1c9b8a2a4ef11996a0b27c2011d4571e17cf977

Domyślnym użytkownikiem jest user, dostęp to niego uzyskujemy za pomocą hasła
user1. Możemy również skorzystać z konta superużytkownika root z hasłem toor.

immudex is not affiliated with Debian. Debian is a registered trademark owned by Software in the Public Interest, Inc.

[https://www.flaticon.com/free-icons/lock](Lock icons created by Freepik - Flaticon) 
