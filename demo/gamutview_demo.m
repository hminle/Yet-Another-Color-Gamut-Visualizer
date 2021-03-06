
% =========================================================================
% demo 1: comparison of visible gamut and sRGB gamut under D65 in CIE1931
% XYZ space
% =========================================================================
clear; close all; clc;

N = 8;
[r, g, b] = meshgrid(linspace(0, 1, N));
rgb = [r(:), g(:), b(:)];

[vol_srgb, ~, hax] = gamutview(rgb, [], 'srgb2xyz', 'edgecolor', 'none');

load('visible_spectra.mat');
xyz = spectra2colors(visible_spectra, wavelengths, 'spd', 'd65');

vol_visible = gamutview(xyz, [], 'xyz2xyz', 'facecolor', 'none', 'parent', hax);

view(-20, 20);

fprintf('%s\nGamut volume in CIE1931 XYZ color space\n', repmat('=', 1, 36));
fprintf('%-25s%.2e\n%-25s%.2e\n', 'sRGB:', vol_srgb, 'Visible spectra:', vol_visible);
fprintf('%s\n', repmat('=', 1, 36));




% =========================================================================
% demo 2: comparison of sRGB gamut and Adobe RGB gamut in CIELUV space
% =========================================================================
clear; close all; clc;

N = 16;
[r, g, b] = meshgrid(linspace(0, 1, N));
rgb = [r(:), g(:), b(:)];

[vol_srgb, ~, hax] = gamutview(rgb, rgb, 'srgb2luv', 'edgecolor', 'none');
vol_argb = gamutview(rgb, rgb, 'argb2luv', 'facecolor', 'none', 'edgecolor', 'k', 'edgealpha', .25, 'parent', hax);

view(-20, 20);

fprintf('%s\nGamut volume in CIELUV color space\n', repmat('=', 1, 36));
fprintf('%-25s%.2e\n%-25s%.2e\n', 'sRGB:', vol_srgb, 'Adobe RGB:', vol_argb);
fprintf('%s\n', repmat('=', 1, 36));




% =========================================================================
% demo 3: comparison of OLED display gamut and sRGB gamut in CIELAB space
% =========================================================================
clear; close all; clc;

load('oled_display_measurements.mat');
[vol_oled, ~, hax] = gamutview(xyz, rgb, 'xyz2lab',...
                               'whitepoint', xyz_whitepoint,...
                               'edgecolor', 'k', 'edgealpha', .2);

N = 8;
[r, g, b] = meshgrid(linspace(0, 1, N));
rgb = [r(:), g(:), b(:)];

vol_srgb = gamutview(rgb, rgb, 'rgb2lab',...
                     'facecolor', 'none', 'linewidth', .5,...
                     'parent', hax);

fprintf('%s\nGamut volume in CIELAB color space\n', repmat('=', 1, 36));
fprintf('%-25s%.2e\n%-25s%.2e\n', 'OLED display:', vol_oled, 'sRGB:', vol_srgb);
fprintf('%s\n', repmat('=', 1, 36));
