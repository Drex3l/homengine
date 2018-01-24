<section id="search-pane" class="page-wrap flash js">
    <p class="bounceUp">
        <a href="#header-inner" id="up1" title="Go Up">
            <svg class="gridicon gridicons-chevron-down" height="32" width="32" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><g><path d="M20 9l-8 8-8-8 1.414-1.414L12 14.172l6.586-6.586"></path></g></svg>
        </a>
    </p>
    <!-- The following container "engine-values" houses hidden elements storing values of the search engine pane selected by user, to be used by AJAX -->
    <span style="display: none" id="engine-values">
        <input type="hidden" id="accom"/>   //----------------------------------ACCOMMODATION TYPE radion button
        <input type="hidden" id="rooms"/>   //----------------------------------ROOMS checkboxes
        <input type="hidden" id="build"/>   //----------------------------------PROPERTY TYPE radio button
        <input type="hidden" id="minP"/>    //----------------------------------MINIMUM PRICE RANGE text box
        <input type="hidden" id="maxP"/>    //----------------------------------MAXIMUM PRICE RANGE text box
        <input type="hidden" id="bed"/>   //------------------------------------BED ROOMS quantity text box
        <input type="hidden" id="bath"/>   //-----------------------------------BATH ROOMS quantity text box
        <input type="hidden" id="bedroom" value="Any"/>   //--------------------SHARING BEDROOM type radio button
        <input type="hidden" id="feat"/>   //----------------------------------Selected Features string
    </span>
    <div id="searchengine" class="feature">
        <div id="row-01"><select name="suburb" id="cmbSuburb">
                <?php foreach ($suburbs as $row) { ?>
                    <option value="<?= $row['SUBURB_ID']; ?>"><?= $row['SUBURB_NAME']; ?></option>
                <?php } ?>    
            </select>
            <input id="btnSearch" value="Find" class="btnMing"type="submit" onclick="search(cmbSuburb, accom, rooms, build, maxP, minP,bed,bath,bedroom,feat)"/></div>
        <div class="sexion">
            <span id="accommodation" class="attribute">
                <h3 onclick="toggleFeature(subAccom)">ACCOMMODATION</h3>
                <div class="sub-attribute" id="subAccom"><hr/>
                    <span class="spacer">
                        <?php foreach ($accom as $value) { ?>
                            <label class="radio-align"><input type="radio" name="accom" value="<?= $value; ?>" required class="rbn" onchange="getValue(this)"/><?= $value; ?></label>
                        <?php } ?>
                    </span>
                </div>
            </span>
            <span id="room" class="attribute">
                <h3 onclick="toggleFeature(subRoom)">ROOMS</h3>
                <div class="sub-attribute" id="subRoom"><hr/>
                    <span class="spacer">
                        <?php foreach ($rooms as $value) { ?><label class="check-align"><input type="checkbox" name="rooms[]" value="<?= $value['ROOM_ID']; ?>" class="chk" onchange="getValues(this.name)"/> <?= $value['ROOM_TYPE']; ?></label><?php } ?>
                    </span>
                </div>
            </span>
            <span id="buildingType" class="attribute">
                <h3 onclick="toggleFeature(subBuild)">PROPERTY TYPE</h3>
                <div class="sub-attribute" id="subBuild" ><hr/>
                    <span class="spacer">
                        <?php foreach ($Btypes as $value) { ?>
                            <label class="radio-align"><input type="radio" name="build" value="<?= $value['TYPE_DESC']; ?>" required class="rbn" onchange="building(this)"/><?= $value['TYPE_DESC']; ?></label>
                        <?php } ?>
                        <label class="radio-align"><input type="radio" required name="build" value="Any" class="rbn" onchange="building(this)"/>Any</label>
                    </span>
                </div>
            </span>
            <span id="pricing" class="attribute">
                <h3 onclick="toggleFeature(subPrice)">PRICE RANGE</h3>
                <div class="sub-attribute" id="subPrice" ><hr/>
                    <input type="number" name="maxP" min="0" placeholder="Maximum" class="txt" step="100" onchange="getValue(this)"/>
                    <input type="number" name="minP" min="0" placeholder="Minimum" class="txt" step="100" onchange="getValue(this)"/>
                    <div class="subset" id="beds"> <h3>BED ROOMS</h3><input type="number" name="bed" min="0" max="5" placeholder="quantity" class="txt" onchange="getValue(this)"/></div>
                    <div class="subset" id="baths"><h3>BATH ROOMS</h3><input type="number" name="bath" min="0" max="5" placeholder="quantity" class="txt" onchange="getValue(this)"/></div>
                    <div class="subset" id="room-setting">
                        <h3>BED ROOM</h3>
                        <label class="radio-align"><input type="radio" name="bedroom" value="Single" class="rbn" onchange="getValue(this)"/>Single</label>
                        <label class="radio-align"><input type="radio" name="bedroom" value="Sharing" class="rbn" onchange="getValue(this)"/>Sharing</label>
                        <label class="radio-align"><input type="radio" name="bedroom" value="Any" class="rbn" checked="true" onchange="getValue(this)"/>Any</label>
                    </div>
                </div>
            </span>
        </div>
        <div id="facility">
            <h2>FEATURES</h2>
            <div class="sexion">
                <span id="accessory" class="attribute"><h3 onclick="toggleFeature(subAccess)">ACCESSORY</h3>
                    <div class="sub-attribute" id="subAccess"><hr>
                            <span class="spacer">
                                <?php foreach ($accessories as $value) { ?>
                                    <label class="check-align"><input type="checkbox" name="feat[]" value="<?= $value['ITEM_CODE']; ?>" class="chk" onchange="getValues(this.name)"/><?= $value['NAME']; ?></label>
                                <?php } ?>
                            </span>
                    </div>
                </span>
                <span id="furnirure" class="attribute"><h3 onclick="toggleFeature(subFurn)">FURNITURE</h3>
                    <div class="sub-attribute" id="subFurn"><hr>
                            <span class="spacer">
                                <?php foreach ($furniture as $value) { ?>
                                    <label class="check-align"><input type="checkbox" name="feat[]" value="<?= $value['ITEM_CODE']; ?>" class="chk" onchange="getValues(this.name)"/><?= $value['NAME']; ?></label>
                                <?php } ?>
                            </span>
                    </div>
                </span>
                <span id="convenience" class="attribute"><h3 onclick="toggleFeature(subModern)">CONVENIENCE</h3>
                    <div class="sub-attribute" id="subModern"><hr>
                            <span class="spacer">
                                <?php foreach ($conveniences as $value) { ?>
                                    <label class="check-align"><input type="checkbox" name="feat[]" value="<?= $value['ITEM_CODE']; ?>" class="chk" onchange="getValues(this.name)"/><?= $value['NAME']; ?></label>
                                <?php } ?>
                            </span>
                    </div>
                </span>
                <span id="sundy" class="attribute" ><h3 onclick="toggleFeature(subSundry)">SUNDRY</h3>
                    <div class="sub-attribute" id="subSundry"><hr>
                            <span class="spacer">
                                <?php foreach ($sundry as $value) { ?>
                                    <label class="check-align"><input type="checkbox" name="feat[]" value="<?= $value['ITEM_CODE']; ?>" class="chk" onchange="getValues(this.name)"/><?= $value['NAME']; ?></label>
                                <?php } ?>
                            </span>
                    </div>
                </span>
            </div>
        </div>
        <span class="error-msg-inline" <?php if (empty($error_message)) {
                                    echo 'style="display:none"';
                                } ?>><?= $error_message; ?></span>
    </div>
</section>
