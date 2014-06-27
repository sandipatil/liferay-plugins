<%--
/**
 * Copyright (c) 2000-present Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */
--%>

<%@ include file="/html/portlet/document_library/init.jsp" %>

<%
FileEntry fileEntry = (FileEntry)request.getAttribute(WebKeys.DOCUMENT_LIBRARY_FILE_ENTRY);

FileVersion fileVersion = (FileVersion)request.getAttribute(WebKeys.DOCUMENT_LIBRARY_FILE_VERSION);

if (fileVersion == null) {
	if ((user.getUserId() == fileEntry.getUserId()) || permissionChecker.isContentReviewer(user.getCompanyId(), scopeGroupId) || DLFileEntryPermission.contains(permissionChecker, fileEntry, ActionKeys.UPDATE)) {
		fileVersion = fileEntry.getLatestFileVersion();
	}
	else {
		fileVersion = fileEntry.getFileVersion();
	}
}

long fileEntryTypeId = 0;

if (fileVersion.getModel() instanceof DLFileVersion) {
	DLFileVersion dlFileVersion = (DLFileVersion)fileVersion.getModel();

	fileEntryTypeId = dlFileVersion.getFileEntryTypeId();
}

boolean isGoogleDocument = false;

if (fileEntryTypeId > 0) {
	DLFileEntryType dlfileEntryType = DLFileEntryTypeLocalServiceUtil.getFileEntryType(fileEntryTypeId);

	if (dlfileEntryType.getFileEntryTypeKey().equals("GOOGLE-DOCUMENT")) {
		isGoogleDocument = true;
	}
}
%>

<c:choose>
	<c:when test="<%= isGoogleDocument %>">
		<style>
			.download-document, .webdav-url, .lfr-asset-panels {
				display: none;
			}
		</style>

		<liferay-util:include page="/html/portlet/document_library/view_file_entry_google_document.jsp" />
	</c:when>
	<c:otherwise>
		<liferay-util:include page="/html/portlet/document_library/view_file_entry.portal.jsp" />
	</c:otherwise>
</c:choose>