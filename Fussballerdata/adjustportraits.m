function adjustportraits(flag)
if nargin==0, flag = 'start'; end
switch flag
    case 'start' % Initialize GUI
        f = figure('Units','Normalized','DefaultUicontrolUnits','Normalized',...
                   'Position',[.1 .1 .8 .8]);
        ud.axes(1) = axes('Parent',f,'Position',[.05 .05 .4 .9]);
        ud.axes(2) = axes('Parent',f,'Position',[.8 .05 .18 .5]);
        ud.button(1) = uicontrol(f,'Position',[.55 .9 .2 .05],'String','right eye',...
                                'FontSize',20,'Callback','adjustportraits(''sr'')');
        ud.check(1) = uicontrol(f,'Position',[.8 .9 .05 .05],'Style','Text','FontSize',20,...
                                'String','');
        ud.button(2) = uicontrol(f,'Position',[.55 .8 .2 .05],'String','left eye',...
                                'FontSize',20,'Callback','adjustportraits(''sl'')');
        ud.check(2) = uicontrol(f,'Position',[.8 .8 .05 .05],'Style','Text','FontSize',20,...
                                'String','');
        ud.button(4) = uicontrol(f,'Position',[.55 .6 .2 .05],'String','Okay',...
                                'FontSize',20,'Callback','adjustportraits(''calculate'')');
        ud.button(5) = uicontrol(f,'Position',[.55 .5 .2 .05],'String','Next please!', ...
                                'FontSize',20,'Callback','adjustportraits(''nextplease'')');
        ud.currfolder = ['.',filesep,'neueBilderblank']; % folder with new files
        ud.all = dir(ud.currfolder); ud.nall = size(ud.all, 1); ud.i = 2;
        ud.verz = [ud.currfolder,filesep,'tmp',filesep]; % folder to copy new files into
        if not(isdir(ud.verz)), mkdir(ud.verz); end
        ud.yetloaded = 0; set(f, 'UserData', ud);
        adjustportraits('nextplease');
    case 'sr'  % Set the right eye
        f = gcf;   ud = get(f,'UserData');
        set(ud.axes(1),'ButtonDownFcn','adjustportraits(''svr'')')
    case 'svr'
        % Save right eye
        f = gcf; ud = get(f, 'UserData');
        xyz = get(ud.axes(1),'CurrentPoint');
        ud.x(1) = round(xyz(1,1)); ud.y(1) = round(xyz(1,2));
        set(ud.check(1),'String','OK'); set(ud.axes(1),'ButtonDownFcn',[]);
        set(f,'UserData',ud);
    case 'sl'   % Set left eye
        f = gcf;     ud = get(f, 'UserData');
        set(ud.axes(1),'ButtonDownFcn','adjustportraits(''svl'')')
    case 'svl' % Save left eye
        f = gcf; ud = get(f, 'UserData');
        xyz = get(ud.axes(1),'CurrentPoint');
        ud.x(2) = round(xyz(1,1)); ud.y(2) = round(xyz(1,2));
        set(ud.check(2),'String','OK'); set(ud.axes(1),'ButtonDownFcn',[]);
        set(f,'UserData', ud);
    case 'calculate'
        f = gcf;   ud = get(f, 'UserData');
        height = 150;  width = 100;                % new dimensions
        [xx,yy] = meshgrid(-width:width, -height:height);
        MP = [ud.x(1)+ud.x(2);ud.y(1)+ud.y(2)]/2;  % center of eye-to-eye-line
        phi = -atan2(ud.y(2)-MP(2), ud.x(2)-MP(1));% angle of it
        skal = 1.3*norm([ud.x(1)-ud.x(2);ud.y(1)-ud.y(2)])/width;
        A = [cos(phi), sin(phi); -sin(phi), cos(phi)];
        tmp = A*[xx(:)';yy(:)']; xx(:) = (tmp(1,:))'; yy(:) = (tmp(2,:))';
        xx = skal*xx + MP(1); yy = skal*yy + MP(2);
        ud.zz = interp2(ud.Bild, xx, yy);          % interpolate for new dimensions
        imagesc(ud.zz, 'Parent', ud.axes(2));
        ud.yetloaded = 1;
        set(f,'UserData', ud);
    case 'nextplease'
        f = gcf; ud = get(f, 'UserData');
        ud.i = ud.i + 1;
        if ud.yetloaded, imwrite(ud.zz/256, [ud.verz,ud.merkedatei],'jpg'); end
        if isdir([ud.currfolder,filesep,ud.all(ud.i).name]), ud.i = ud.i+1; end
        if ud.i > ud.nall, disp('DONE'); return;
        else
            datei = [ud.currfolder,filesep,ud.all(ud.i).name];
            ud.Bild = double(imread(datei));
            ud.merkedatei = datei(length(ud.currfolder)+1:end);
            if size(ud.Bild,3) > 1, ud.Bild = sum(ud.Bild,3)/3;  end
        end
        if ud.yetloaded, imwrite(ud.zz/256, [ud.verz,ud.merkedatei],'jpg'); end
        bild = imagesc(ud.Bild,'Parent',ud.axes(1));
        set(bild,'HitTest','Off');  colormap gray; axis image
        set(f, 'UserData', ud); set(ud.check(1),'String','');set(ud.check(2),'String','');
    otherwise
        error(['Unknown flag: ',flag]);
end