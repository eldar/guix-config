;; This is an operating system configuration generated
;; by the graphical installer.
;;
;; Once installation is complete, you can learn and modify
;; this file to tweak the system configuration, and pass it
;; to the 'guix system reconfigure' command to effect your
;; changes.


;; Indicate which modules to import to access the variables
;; used in this configuration.
(use-modules (gnu))
;; (use-modules (gnu packages))
(use-modules (nongnu packages linux)
 	     (nongnu system linux-initrd))
(use-modules (gnu services xorg)
             ;; (gnu services qemu)
             (nongnu packages nvidia)
             (nongnu services nvidia))

;; (use-modules (gnu packages version-control))

(use-service-modules
  cups
  desktop
  networking
  nix
  ssh
  xorg
  virtualization)

(use-package-modules
  version-control
  package-management
  gnome
  ssh
  terminals)

(operating-system
  (kernel linux-lts)
  (initrd microcode-initrd)
  (firmware (list nvidia-firmware
		  linux-firmware))
  (locale "en_GB.utf8")
  (timezone "Europe/London")
  (keyboard-layout (keyboard-layout "us"))
  (host-name "mars")

  ;; The list of user accounts ('root' is implicit).
  (users (cons* (user-account
                  (name "eldar")
                  (comment "Eldar Insafutdinov")
                  (group "users")
                  (home-directory "/home/eldar")
                  (supplementary-groups '("wheel" "netdev" "audio" "video")))
                %base-user-accounts))

  (kernel-arguments '("modprobe.blacklist=nouveau"
                      ;; Set this if the card is not used for displaying or
                      ;; you're using Wayland:
                      "nvidia_drm.modeset=1"))

  (packages 
   (cons* git
	  openssh
          %base-packages))

  ;; Below is the list of system services.  To search for available
  ;; services, run 'guix system search KEYWORD' in a terminal.
  (services
   (cons* (service gnome-desktop-service-type)
	  (service nvidia-service-type)
	  (service nix-service-type)
	  ;; (service qemu-guest-agent-service-type)
	  (service openssh-service-type)
	  (set-xorg-configuration
	    (xorg-configuration (keyboard-layout keyboard-layout)))

	  (modify-services %desktop-services
	   (gdm-service-type config =>
	     (gdm-configuration
	      (inherit config)
	      (wayland? #t)))
             ;; Nonguix substitute services
           (guix-service-type config => (guix-configuration
             (inherit config)
             (substitute-urls
              (append (list "https://substitutes.nonguix.org")
                %default-substitute-urls))
             (authorized-keys
              (append (list (local-file "./substitutes.nonguix.org.pub"))
                %default-authorized-guix-keys)))))))

  (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets (list "/boot/efi"))
                (keyboard-layout keyboard-layout)))

  ;; (swap-devices (list (swap-space
  ;;                      (target (uuid
  ;;                               "51775bbd-fa33-496a-a0fb-1f76da456126")))))


  ;; The list of file systems that get "mounted".  The unique
  ;; file system identifiers there ("UUIDs") can be obtained
  ;; by running 'blkid' in a terminal.
  (file-systems (cons* (file-system
                         (mount-point "/home")
                         (device (uuid
                                  "a2bf19c0-ca15-46a9-9f97-c82de90fb6ca"
                                  'ext4))
                         (type "ext4"))
                       (file-system
                         (mount-point "/")
                         (device (uuid
                                  "7b79fb22-d509-404b-942d-05934bac7302"
                                  'ext4))
                         (type "ext4"))
                       (file-system
                         (mount-point "/boot/efi")
                         (device (uuid "7DD1-4EDE"
                                       'fat32))
                         (type "vfat")) %base-file-systems)))
