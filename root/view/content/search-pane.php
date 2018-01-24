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
        <input type="hidden" id="bedsR"/>   //----------------------------------BED ROOMS quantity text box
        <input type="hidden" id="bathR"/>   //----------------------------------BATH ROOMS quantity text box
        <input type="hidden" id="roomT"/>   //----------------------------------SHARING BEDROOM type radio button
        <input type="hidden" id="featS"/>   //----------------------------------Selected Features string
    </span>
    <div id="searchengine" class="feature">
        <div id="row-01"><select name="suburb" id="cmbSuburb">
                            <?php 
                            foreach ($suburbs as $row) {?>
                                    <option value="<?= $row['SUBURB_ID']; ?>"><?= $row['SUBURB_NAME']; ?></option>
                            <?php }?>    
                        </select>
            <input id="btnSearch" value="Find" class="btnMing"type="submit" onclick="search(cmbSuburb,accom)"/></div>
        <div class="sexion">
            <span id="accommodation" class="attribute">
                <h3 onclick="toggleFeature(subAccom)">ACCOMMODATION</h3>
                <div class="sub-attribute" id="subAccom"><hr/>
                    <span class="spacer">
                        <?php foreach ($accom as $value) { ?>
                            <label class="radio-align"><input type="radio" name="accom" value="<?= $value; ?>" required class="rbn"/><?= $value; ?></label>
                        <?php } ?>
                    </span>
                </div>
            </span>
            <span id="room" class="attribute">
                <h3 onclick="toggleFeature(subRoom)">ROOMS</h3>
                <div class="sub-attribute" id="subRoom"><hr/>
                    <span class="spacer">
                        <?php foreach ($rooms as $value) { ?><label class="check-align"><input type="checkbox" name="room[]" value="<?= $value['ROOM_ID']; ?>" class="chk"/> <?= $value['ROOM_TYPE']; ?></label><?php } ?>
                    </span>
                </div>
            </span>
            <span id="buildingType" class="attribute">
                <h3 onclick="toggleFeature(subBuild)">PROPERTY TYPE</h3>
                <div class="sub-attribute" id="subBuild" ><hr/>
                    <span class="spacer">
                        <?php foreach ($Btypes as $value) { ?>
                        <label class="radio-align"><input type="radio" name="building" value="<?= $value['TYPE_DESC']; ?>" required class="rbn" onchange="building(this)"/><?= $value['TYPE_DESC']; ?></label>
                        <?php } ?>
                            <label class="radio-align"><input type="radio" required name="building" value="Any" class="rbn" onchange="building(this)"/>Any</label>
                    </span>
                </div>
            </span>
            <span id="pricing" class="attribute">
                <h3 onclick="toggleFeature(subPrice)">PRICE RANGE</h3>
                <div class="sub-attribute" id="subPrice" ><hr/>
                        <input type="number" name="minprice" min="0" placeholder="Minimum" class="txt"/>
                        <input type="number" name="maxprice" min="0" placeholder="Maximum" class="txt"/>
                        <div class="subset" id="beds"> <h3>BED ROOMS</h3><input type="number" name="beds" min="0" max="5" placeholder="quantity" class="txt"/></div>
                        <div class="subset" id="baths"><h3>BATH ROOMS</h3><input type="number" name="baths" min="0" max="5" placeholder="quantity" class="txt"/></div>
                        <div class="subset" id="room-setting">
                            <h3>BED ROOM</h3>
                            <label class="radio-align"><input type="radio" name="bedroom" value="Single" class="rbn"/>Single</label>
                            <label class="radio-align"><input type="radio" name="bedroom" value="Sharing" class="rbn"/>Sharing</label>
                            <label class="radio-align"><input type="radio" name="bedroom" value="Any" class="rbn" checked="true"/>Any</label>
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
                                    <label class="check-align"><input type="checkbox" name="accessory[]" value="<?= $value['ITEM_CODE']; ?>" class="chk"/><?= $value['NAME']; ?></label>
                                <?php } ?>
                            </span>
                    </div>
                </span>
                <span id="furnirure" class="attribute"><h3 onclick="toggleFeature(subFurn)">FURNITURE</h3>
                    <div class="sub-attribute" id="subFurn"><hr>
                            <span class="spacer">
                                <?php foreach ($furniture as $value) { ?>
                                    <label class="check-align"><input type="checkbox" name="furnirure[]" value="<?= $value['ITEM_CODE']; ?>" class="chk"/><?= $value['NAME']; ?></label>
                                <?php } ?>
                            </span>
                    </div>
                </span>
                <span id="convenience" class="attribute"><h3 onclick="toggleFeature(subModern)">CONVENIENCE</h3>
                    <div class="sub-attribute" id="subModern"><hr>
                            <span class="spacer">
                                  <?php foreach ($conveniences as $value) { ?>
                                    <label class="check-align"><input type="checkbox" name="convenience[]" value="<?= $value['ITEM_CODE']; ?>" class="chk"/><?= $value['NAME']; ?></label>
                                <?php } ?>
                            </span>
                    </div>
                </span>
                <span id="sundy" class="attribute" ><h3 onclick="toggleFeature(subSundry)">SUNDRY</h3>
                    <div class="sub-attribute" id="subSundry"><hr>
                            <span class="spacer">
                                <?php foreach ($sundry as $value) { ?>
                                    <label class="check-align"><input type="checkbox" name="sundy[]" value="<?= $value['ITEM_CODE']; ?>" class="chk"/><?= $value['NAME']; ?></label>
                                <?php } ?>
                            </span>
                    </div>
                </span>
            </div>
        </div>
        <span class="error-msg-inline" <?php if(empty($error_message)){ echo 'style="display:none"';} ?>><?= $error_message; ?></span>
    </div>
</section>
