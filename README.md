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

**Uwaga! Ze względu na zmianę domeny, aby zaktualizować immudex z wersji 0.1.0
należy na początku pobrać z repozytorium (tools/011) wersję 'immudex_upgrade' 
wraz z biblioteką 'library.sh' dedykowaną dla wersji 0.1.1 lub dokonać 
aktualizacji ręcznie.**

  * 64-bit: [https://ftp.morketsmerke.org/immudex/stable/iso/0.1.1/immudex64.iso](https://ftp.morketsmerke.org/immudex/stable/iso/0.1.1/immudex64.iso)
    
    CRC: 2426717088 SHA1: 8a4e3337ed987ced17b1dd0ef66300516e2b584a
  * 32-bit: [https://ftp.morketsmerke.org/immudex/stable/iso/0.1.1/immudex32.iso](https://ftp.morketsmerke.org/immudex/stable/iso/0.1.1/immudex32.iso)
    
    CRC: 4281820074 SHA1: d225718329db8bdc63cc7cca7ed411ad9f07bd26

Domyślnym użytkownikiem jest user, dostęp to niego uzyskujemy za pomocą hasła
user1. Możemy również skorzystać z konta superużytkownika root z hasłem toor.

immudex is not affiliated with Debian. Debian is a registered trademark owned 
by Software in the Public Interest, Inc.

[Lock icons created by Freepik - Flaticon](https://www.flaticon.com/free-icons/lock)

[Rss icons created by Freepik - Flaticon](https://www.flaticon.com/free-icons/rss)
 
