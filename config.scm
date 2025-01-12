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
(use-modules (nongnu packages linux))
;; (use-modules (nongnu packages linux)
;; 	     (nongnu system linux-initrd))
(use-modules (gnu services xorg)
             ;; (gnu services qemu)
             (nongnu packages nvidia)
             (nongnu services nvidia))

(use-service-modules
  cups
  desktop
  networking
  nix
  ssh
  xorg
  virtualization)

(use-package-modules
  package-management
  gnome
  ssh
  terminals
  spice)

(operating-system
  (kernel linux)
  ;;(initrd microcode-initrd)
  ;;(firmware (list linux-firmware))
  (firmware (append (list nvidia-firmware)
		    %base-firmware))
  (locale "en_GB.utf8")
  (timezone "Europe/London")
  (keyboard-layout (keyboard-layout "us"))
  (host-name "ganymede")

  ;; The list of user accounts ('root' is implicit).
  (users (cons* (user-account
                  (name "eldar")
                  (comment "Eldar")
                  (group "users")
                  (home-directory "/home/eldar")
                  (supplementary-groups '("wheel" "netdev" "audio" "video")))
                %base-user-accounts))

  ;; Packages installed system-wide.  Users can also install packages
  ;; under their own account: use 'guix search KEYWORD' to search
  ;; for packages and 'guix install PACKAGE' to install a package.
  ;;(packages (append (list (specification->package "nss-certs"))
  ;;                  %base-packages))
  (packages 
   (cons* kitty
	  openssh
          spice-vdagent
          %base-packages))

  (kernel-arguments '("modprobe.blacklist=nouveau"
                      ;; Set this if the card is not used for displaying or
                      ;; you're using Wayland:
                      "nvidia_drm.modeset=1"))

  ;; Below is the list of system services.  To search for available
  ;; services, run 'guix system search KEYWORD' in a terminal.
  (services
   (cons* (service gnome-desktop-service-type)
	  (service nvidia-service-type)
	  (service nix-service-type)
	  (service qemu-guest-agent-service-type)
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
  (swap-devices (list (swap-space
                        (target (uuid
                                 "51775bbd-fa33-496a-a0fb-1f76da456126")))))

  ;; The list of file systems that get "mounted".  The unique
  ;; file system identifiers there ("UUIDs") can be obtained
  ;; by running 'blkid' in a terminal.
  (file-systems (cons* (file-system
                         (mount-point "/home")
                         (device (uuid
                                  "06e46b55-809c-4f3a-b765-29cf05e94aea"
                                  'ext4))
                         (type "ext4"))
                       (file-system
                         (mount-point "/")
                         (device (uuid
                                  "0f0464ba-ff65-4483-8ded-21243ecfc5c3"
                                  'ext4))
                         (type "ext4"))
                       (file-system
                         (mount-point "/boot/efi")
                         (device (uuid "6D53-72AF"
                                       'fat32))
                         (type "vfat")) %base-file-systems)))
