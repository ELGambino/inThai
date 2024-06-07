import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ClientNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  ClientNavBar({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 10,
      backgroundColor: Colors.blueGrey.withOpacity(0.8),
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: SvgPicture.string(''' <svg width="33" height="32" viewBox="0 0 33 32" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M27.2434 15.0674L27.2415 15.066L17.1748 7.51929L16.8749 7.29445L16.575 7.51929L6.50834 15.066L6.50826 15.066C6.40217 15.1456 6.26882 15.1797 6.13755 15.161C6.00627 15.1422 5.88782 15.0721 5.80826 14.966C5.72869 14.8599 5.69453 14.7266 5.71328 14.5953C5.73203 14.464 5.80217 14.3456 5.90826 14.266L16.5749 6.26602C16.6615 6.2011 16.7667 6.16602 16.8749 6.16602C16.9831 6.16602 17.0884 6.2011 17.1749 6.26602L27.8325 14.2592C27.9259 14.3375 27.9875 14.4474 28.0056 14.5681C28.0241 14.6914 27.9959 14.8172 27.9264 14.9208L27.9213 14.9284L27.9164 14.9362C27.8745 15.004 27.8166 15.0604 27.7478 15.1005L27.9997 15.5324L27.7478 15.1005C27.6815 15.1392 27.6071 15.1616 27.5306 15.166C27.4269 15.1646 27.3262 15.1301 27.2434 15.0674Z" stroke="#432F24"/>
<path d="M25.375 12.666V25.3288C25.3726 25.4617 25.3187 25.5884 25.2247 25.6824C25.1308 25.7764 25.004 25.8302 24.8712 25.8327H8.87881C8.74599 25.8302 8.61925 25.7764 8.52526 25.6824C8.43128 25.5884 8.37744 25.4617 8.375 25.3289V12.666C8.375 12.5334 8.42768 12.4062 8.52145 12.3125C8.61522 12.2187 8.74239 12.166 8.875 12.166C9.00761 12.166 9.13478 12.2187 9.22855 12.3125C9.32232 12.4062 9.375 12.5334 9.375 12.666V24.3327V24.8327H9.875H23.875H24.375V24.3327V12.666C24.375 12.5334 24.4277 12.4062 24.5214 12.3125C24.6152 12.2187 24.7424 12.166 24.875 12.166C25.0076 12.166 25.1348 12.2187 25.2286 12.3125C25.3223 12.4062 25.375 12.5334 25.375 12.666Z" fill="#432F24" stroke="#432F24"/>
<path d="M19.5416 26.3333C19.2774 26.3299 19.0251 26.2234 18.8383 26.0366C18.6515 25.8498 18.545 25.5975 18.5416 25.3333V17H15.2083V25.3333C15.2083 25.5985 15.1029 25.8529 14.9154 26.0404C14.7278 26.228 14.4735 26.3333 14.2083 26.3333C13.943 26.3333 13.6887 26.228 13.5011 26.0404C13.3136 25.8529 13.2083 25.5985 13.2083 25.3333V16C13.2117 15.7359 13.3182 15.4835 13.505 15.2967C13.6918 15.1099 13.9441 15.0035 14.2083 15H19.5416C19.8057 15.0035 20.0581 15.1099 20.2449 15.2967C20.4317 15.4835 20.5381 15.7359 20.5416 16V25.3333C20.5381 25.5975 20.4317 25.8498 20.2449 26.0366C20.0581 26.2234 19.8057 26.3299 19.5416 26.3333Z" fill="#432F24"/>
</svg>

''',
            color: currentIndex == 0 ? null : Colors.grey.shade800,
          ),
          label: 'Główna',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.string('''<svg width="33" height="32" viewBox="0 0 33 32" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M25.9584 16.5H11.2917C11.1591 16.5 11.032 16.4473 10.9382 16.3536C10.8444 16.2598 10.7917 16.1326 10.7917 16C10.7917 15.8674 10.8444 15.7402 10.9382 15.6464C11.032 15.5527 11.1591 15.5 11.2917 15.5H25.9584C26.091 15.5 26.2182 15.5527 26.312 15.6464C26.4057 15.7402 26.4584 15.8674 26.4584 16C26.4584 16.1326 26.4057 16.2598 26.312 16.3536C26.2182 16.4473 26.091 16.5 25.9584 16.5Z" stroke="#432F24"/>
<path d="M25.9584 10.5H11.2917C11.1591 10.5 11.032 10.4473 10.9382 10.3536C10.8444 10.2598 10.7917 10.1326 10.7917 10C10.7917 9.86739 10.8444 9.74021 10.9382 9.64645C11.032 9.55268 11.1591 9.5 11.2917 9.5H25.9584C26.091 9.5 26.2182 9.55268 26.312 9.64645C26.4057 9.74021 26.4584 9.86739 26.4584 10C26.4584 10.1326 26.4057 10.2598 26.312 10.3536C26.2182 10.4473 26.091 10.5 25.9584 10.5Z" fill="#432F24" stroke="#432F24"/>
<path d="M25.9584 23H11.2917C11.0265 23 10.7722 22.8946 10.5846 22.7071C10.3971 22.5196 10.2917 22.2652 10.2917 22C10.2917 21.7348 10.3971 21.4804 10.5846 21.2929C10.7722 21.1054 11.0265 21 11.2917 21H25.9584C26.2236 21 26.478 21.1054 26.6655 21.2929C26.8531 21.4804 26.9584 21.7348 26.9584 22C26.9584 22.2652 26.8531 22.5196 26.6655 22.7071C26.478 22.8946 26.2236 23 25.9584 23Z" fill="#432F24"/>
<path d="M7.29161 11.3338C7.11826 11.336 6.94616 11.3043 6.78494 11.2405C6.62561 11.1632 6.47758 11.0645 6.34494 10.9472C6.22137 10.8226 6.1236 10.6748 6.05725 10.5124C5.99089 10.3499 5.95726 10.176 5.95827 10.0005C5.96319 9.64749 6.1013 9.30936 6.34494 9.05385C6.4701 8.93038 6.62008 8.83493 6.78494 8.77385C7.10956 8.64049 7.47366 8.64049 7.79827 8.77385C7.96194 8.83731 8.11147 8.93246 8.23827 9.05385C8.48192 9.30936 8.62003 9.64749 8.62494 10.0005C8.62596 10.176 8.59232 10.3499 8.52597 10.5124C8.45962 10.6748 8.36185 10.8226 8.23827 10.9472C8.10563 11.0645 7.9576 11.1632 7.79827 11.2405C7.63706 11.3043 7.46496 11.336 7.29161 11.3338Z" fill="#432F24"/>
<path d="M7.29161 17.3341C7.11737 17.332 6.94524 17.2958 6.78494 17.2274C6.62336 17.1599 6.47454 17.0652 6.34494 16.9474C6.22137 16.8228 6.1236 16.6751 6.05725 16.5126C5.99089 16.3502 5.95726 16.1762 5.95827 16.0008C5.96319 15.6477 6.1013 15.3096 6.34494 15.0541C6.47454 14.9363 6.62336 14.8416 6.78494 14.7741C7.0263 14.6622 7.29563 14.625 7.55827 14.6674L7.79827 14.7474L8.03827 14.8674C8.10812 14.9167 8.17491 14.9701 8.23827 15.0274C8.48824 15.2896 8.62683 15.6385 8.62494 16.0008C8.62494 16.3544 8.48446 16.6935 8.23442 16.9436C7.98437 17.1936 7.64523 17.3341 7.29161 17.3341Z" fill="#432F24"/>
<path d="M7.29165 23.3342C7.1183 23.3363 6.9462 23.3046 6.78498 23.2408C6.62566 23.1635 6.47763 23.0648 6.34498 22.9475C6.22721 22.8179 6.13251 22.6691 6.06498 22.5075C5.99444 22.3479 5.95801 22.1753 5.95801 22.0008C5.95801 21.8263 5.99444 21.6538 6.06498 21.4942C6.13251 21.3326 6.22721 21.1838 6.34498 21.0542C6.53248 20.8692 6.77058 20.7438 7.02923 20.694C7.28789 20.6442 7.5555 20.6721 7.79832 20.7742C7.96199 20.8376 8.11151 20.9328 8.23832 21.0542C8.35609 21.1838 8.4508 21.3326 8.51832 21.4942C8.58886 21.6538 8.62529 21.8263 8.62529 22.0008C8.62529 22.1753 8.58886 22.3479 8.51832 22.5075C8.4508 22.6691 8.35609 22.8179 8.23832 22.9475C8.11373 23.0711 7.96598 23.1688 7.80353 23.2352C7.64108 23.3016 7.46713 23.3352 7.29165 23.3342Z" fill="#432F24"/>
</svg>

'''),
          label: 'Usługi',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.string('''<svg width="33" height="32" viewBox="0 0 33 32" fill="none" xmlns="http://www.w3.org/2000/svg">
<circle cx="16.3751" cy="15.9993" r="13.3333" stroke="#432F24" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M20.3749 10.6659C18.0706 10.6658 16.375 12.8881 16.375 12.8881C16.375 12.8881 14.8396 10.6659 12.375 10.6659C10.0543 10.6659 8.37508 12.2532 8.375 14.4754C8.37508 16.6976 9.17508 18.0733 11.575 20.2955C13.1751 21.777 16.375 23.9992 16.375 23.9992C16.375 23.9992 19.575 21.777 21.1749 20.2955C23.575 18.0733 24.375 16.6976 24.375 14.4754C24.375 12.2532 22.6956 10.666 20.3749 10.6659Z" stroke="#432F24" stroke-width="1.5"/>
</svg>

'''),
          label: 'Rezerwacje',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.string('''<svg width="33" height="32" viewBox="0 0 33 32" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M28.125 28.0007C23.405 29.0673 19.2583 29.334 16.125 29.334C11.2583 29.334 7.165 28.6807 4.125 28.0007C4.125 22.1073 9.49833 17.334 16.125 17.334C22.7517 17.334 28.125 22.1073 28.125 28.0007Z" stroke="url(#paint0_diamond_403_3566)" stroke-width="1.5" stroke-miterlimit="10" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M16.1251 13.3327C19.0706 13.3327 21.4584 10.9449 21.4584 7.99935C21.4584 5.05383 19.0706 2.66602 16.1251 2.66602C13.1796 2.66602 10.7917 5.05383 10.7917 7.99935C10.7917 10.9449 13.1796 13.3327 16.1251 13.3327Z" stroke="url(#paint1_diamond_403_3566)" stroke-width="1.5" stroke-miterlimit="10" stroke-linecap="round" stroke-linejoin="round"/>
<defs>
<radialGradient id="paint0_diamond_403_3566" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(16.0635 23.2163) scale(26.0308 49.7647)">
<stop stop-color="#BE7F27"/>
<stop offset="1" stop-color="#D7B613"/>
</radialGradient>
<radialGradient id="paint1_diamond_403_3566" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(16.0977 7.89477) scale(11.5692 44.2353)">
<stop stop-color="#BE7F27"/>
<stop offset="1" stop-color="#D7B613"/>
</radialGradient>
</defs>
</svg>
'''),
          label: 'Profil'
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      onTap: onTap,

    );
  }
}